# frozen_string_literal: true

require_relative "../../../../lib/alloverit/patterns/chain_of_responsibility/chain_of_responsibility_handler"

RSpec.describe AllOverIt::Patterns::ChainOfResponsibility::ChainOfResponsibilityHandler do
  let(:handler1) { DummyHandler1.new }
  let(:handler2) { DummyHandler2.new }

  describe "#initialize" do
    context "when trying to instantiate ChainOfResponsibilityHandler" do
      it "raises a NotImplementedError" do
        expect { described_class.new }.to raise_error(NotImplementedError, "ChainOfResponsibilityHandler is abstract")
      end
    end

    context "when instantiating a concrete implementation" do
      it "has no next handler" do
        expect(handler1.instance_variable_get(:@next_handler)).to be_nil
      end
    end
  end

  describe "#next_handler" do
    context "when given a nil handler" do
      it "raises an ArgumentError" do
        expect { handler1.next_handler(nil) }.to raise_error(ArgumentError, "A Chain Of Responsibility handler cannot be nil")
      end
    end

    context "when given a non-nil handler" do
      before do
        handler1.next_handler(handler2)
      end

      it "sets the next handler" do
        expect(handler1.instance_variable_get(:@next_handler)).to eq(handler2)
      end

      it "returns the next handler" do
        next_handler = handler1.next_handler(handler2)

        expect(next_handler).to eq(handler2)
      end
    end
  end

  describe "#handle" do
    let(:handler1) { DummyTargetHandler.new(10) }

    context "when given one handler" do
      context "that matches the target value" do
        it "returns the target value" do
          expect(handler1.handle(10)).to eq(10)
        end
      end

      context "that does not match the target value" do
        it "returns nil" do
          expect(handler1.handle(0)).to be_nil
        end
      end
    end

    context "when given multiple handlers" do
      let(:handler) do
        AllOverIt::Patterns::ChainOfResponsibility.compose(
          DummyTargetHandler.new(10),
          DummyTargetHandler.new(20),
          DummyTargetHandler.new(30))
      end

      context "that matches the target of handler 1" do
        it "returns the target value" do
          expect(handler.handle(10)).to eq(10)
        end
      end

      context "that matches the target of handler 2" do
        it "returns the target value" do
          expect(handler.handle(20)).to eq(20)
        end
      end

      context "that matches the target of handler 3" do
        it "returns the target value" do
          expect(handler.handle(30)).to eq(30)
        end
      end

      context "that does not match any target value" do
        it "returns nil" do
          expect(handler.handle(0)).to be_nil
        end
      end
    end
  end
end
