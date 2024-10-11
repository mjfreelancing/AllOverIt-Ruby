# frozen_string_literal: true

PipelineStep = AllOverIt::Patterns::Pipeline::PipelineStep

RSpec.describe AllOverIt::Patterns::Pipeline do
  it "has a version number" do
    expect(AllOverIt::Patterns::Pipeline::VERSION).not_to be nil
  end

  describe ".create" do
    it "should create a pipeline" do
      expect(described_class.create).to be_an_instance_of(AllOverIt::Patterns::Pipeline::Pipeline)
    end
  end
end

RSpec.describe AllOverIt::Patterns::Pipeline::Pipeline do
  let(:step1) { DummyStep.new }
  let(:step2) { DummyStep.new(2) }

  it "does not allow access to BlockStep" do
    expect { described_class::BlockStep }.to raise_error(NameError, /private constant AllOverIt::Patterns::Pipeline::Pipeline::BlockStep/)
  end

  describe "#initialize" do
    it "initializes an empty array of steps" do
      expect(subject.instance_variable_get(:@steps)).to be_empty
    end
  end

  describe "#step" do
    context "when given a nil step" do
      it "raises an ArgumentError" do
        expect { subject.step(nil) }.to raise_error(ArgumentError, "A pipeline step must inherit #{PipelineStep.name} or have a call method that accepts exactly one argument")
      end
    end

    context "when given a non-nil step" do
      context "that is a PipelineStep" do
        it "is appended to the array of steps" do
          subject.step(step1)
          subject.step(step2)

          steps = subject.instance_variable_get(:@steps)

          expect(steps.count).to be(2)
          expect(steps[0]).to be(step1)
          expect(steps[1]).to be(step2)
        end
      end

      context "that is a Block" do
        let!(:block_step) { subject.step { |input| input + 2 } }

        it "is appended to the array of steps" do
          steps = subject.instance_variable_get(:@steps)

          expect(steps.count).to be(1)
        end

        it "be a PipelineStep" do
          steps = subject.instance_variable_get(:@steps)

          expect(steps[0]).to be_kind_of(PipelineStep)
        end

        it "wraps the provided block" do
          provided_block = proc { |input| input + 2 }
          subject.step(&provided_block)

          # There are now 2 steps in the subject
          step = subject.instance_variable_get(:@steps)[1]

          wrapped_block = step.instance_variable_get(:@block)

          expect(wrapped_block).to eq(provided_block)
        end
      end

      it "returns itself so method calls can be chained" do
        result = subject.step(step1)

        is_expected.to be(result)
      end
    end

    context "when given a step and a block" do
      it "raises an ArgumentError" do
        expect do
          subject.step(step1) do |input|
            input * 3
          end
        end.to raise_error(ArgumentError, "Cannot provide both a pipeline step and a block")
      end
    end
  end

  describe "#call" do
    let(:step3) { DummyStep.new(3) }

    before { subject.step(step1).step(step2).step(step3).step { |input| input * 4 } }

    it "should reduce the input by calling all steps" do
      expect(subject.call(1)).to be(24)
      expect(subject.call(0)).to be(0)
      expect(subject.call(-1)).to be(-24)
    end
  end
end
