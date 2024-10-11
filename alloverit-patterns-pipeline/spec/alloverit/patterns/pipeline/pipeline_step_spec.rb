# frozen_string_literal: true

PipelineStep = AllOverIt::Patterns::Pipeline::PipelineStep

RSpec.describe AllOverIt::Patterns::Pipeline::PipelineStep do
  it "must be a concrete implementation" do
    expect do
      PipelineStep.new.call(nil)
    end.to raise_error(NotImplementedError, "'#{PipelineStep.name}' has not implemented 'call'")
  end

  describe "#call" do
    subject { DummyStep.new(3) }

    it "should invoke and return the expected result" do
      expect(subject.call(1)).to be(3)
      expect(subject.call(-1)).to be(-3)
      expect(subject.call(3)).to be(9)
      expect(subject.call(-3)).to be(-9)
    end
  end
end
