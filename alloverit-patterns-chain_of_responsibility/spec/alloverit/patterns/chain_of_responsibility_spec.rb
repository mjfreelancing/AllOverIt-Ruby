# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/chain_of_responsibility/version"

RSpec.describe AllOverIt::Patterns::ChainOfResponsibility do
  let(:dummy_handler1) { DummyHandler1.new }
  let(:dummy_handler2) { DummyHandler2.new }

  describe ".compose" do
    context "when handlers is nil" do
      it "raises ArgumentError " do
        expect do
          described_class.compose(nil)
        end.to raise_error(ArgumentError, "The handlers cannot be empty.")
      end
    end

    context "when no handlers are provided" do
      it "raises ArgumentError " do
        expect do
          described_class.compose
        end.to raise_error(ArgumentError, "The handlers cannot be empty.")
      end
    end

    context "when given a class" do
      it "returns an instance" do
        expect(described_class.compose(DummyHandler1)).to be_instance_of(DummyHandler1)
      end
    end

    context "when given an instance" do
      it "returns the same instance" do
        expect(described_class.compose(dummy_handler1)).to eq(dummy_handler1)
      end
    end

    context "when given multiple instances" do
      it "returns the first instance" do
        expect(described_class.compose(dummy_handler1, dummy_handler2)).to eq(dummy_handler1)
      end
    end

    context "when given multiple classes" do
      it "returns the first class as an instance" do
        expect(described_class.compose(DummyHandler1, DummyHandler2)).to be_instance_of(DummyHandler1)
      end
    end

    context "when given an instance and a class" do
      it "returns the first instance" do
        expect(described_class.compose(dummy_handler1, DummyHandler2)).to eq(dummy_handler1)
      end
    end

    context "when given a class and an instance" do
      it "returns the first class as an instance" do
        expect(described_class.compose(DummyHandler1, dummy_handler2)).to be_instance_of(DummyHandler1)
      end
    end

    context "when given a nil handler" do
      context "in the first position" do
        it "raises an ArgumentError" do
          expect do
            described_class.compose(nil, dummy_handler1, dummy_handler2)
          end.to raise_error(ArgumentError, "instance_or_class cannot be nil")
        end
      end

      context "in the second position" do
        it "raises an ArgumentError" do
          expect do
            described_class.compose(dummy_handler1, nil, dummy_handler2)
          end.to raise_error(ArgumentError, "instance_or_class cannot be nil")
        end
      end

      context "in the last position" do
        it "raises an ArgumentError" do
          expect do
            described_class.compose(dummy_handler1, dummy_handler2, nil)
          end.to raise_error(ArgumentError, "instance_or_class cannot be nil")
        end
      end
    end

    context "when composed" do
      context "with one handler" do
        it "returns the same handler" do
          handler = described_class.compose(dummy_handler1)

          expect(handler).to eq(dummy_handler1)
        end
      end

      context "with more than one handler" do
        it "returns the first handler" do
          handler = described_class.compose(dummy_handler1, dummy_handler2)

          expect(handler).to eq(dummy_handler1)
        end
      end
    end
  end
end
