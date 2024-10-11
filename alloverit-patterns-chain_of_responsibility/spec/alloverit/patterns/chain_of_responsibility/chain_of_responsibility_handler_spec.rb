# frozen_string_literal: true

require_relative "../../../../lib/alloverit/patterns/chain_of_responsibility/chain_of_responsibility_handler"

ChainOfResponsibilityHandler = AllOverIt::Patterns::ChainOfResponsibility::ChainOfResponsibilityHandler

RSpec.describe ChainOfResponsibilityHandler do
  let(:handler1) { DummyHandler1.new }
  let(:handler2) { DummyHandler2.new }

  it "does not allow access to BlockHandler" do
    expect { described_class::BlockHandler }.to raise_error(NameError, /private constant AllOverIt::Patterns::ChainOfResponsibility::ChainOfResponsibilityHandler::BlockHandler/)
  end

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
        expect { handler1.next_handler(nil) }.to raise_error(ArgumentError, "A Chain of Responsibility handler must inherit #{ChainOfResponsibilityHandler.name} or have a call method that accepts exactly one argument")
      end
    end

    context "when given a non-nil handler" do
      context "that is a ChainOfResponsibilityHandler" do
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

      context "that is a block" do
        let!(:block_handler) { handler1.next_handler { |request| request == true } }

        it "sets the next handler" do
          expect(handler1.instance_variable_get(:@next_handler)).to eq(block_handler)
        end

        it "be a ChainOfResponsibilityHandler" do
          next_handler = handler1.next_handler { |request| request == true }

          expect(next_handler).to be_kind_of(ChainOfResponsibilityHandler)
        end

        it "wraps the provided block" do
          provided_block = proc { |request| request == true }
          handler = handler1.next_handler(&provided_block)

          wrapped_block = handler.instance_variable_get(:@block)

          expect(wrapped_block).to eq(provided_block)
        end
      end
    end

    context "when given a handler and a block" do
      it "raises an ArgumentError" do
        expect do
          handler1.next_handler(handler2) do |request|
            request == true
          end
        end.to raise_error(ArgumentError, "Cannot provide both a handler and a block")
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

    context "when given a block" do
      it "returns the block result when the request handled" do
        handler1.next_handler { |request| request.even? ? request : nil }

        expect(handler1.handle(20)).to be(20)
      end

      it "returns nil when the block does not handle the request" do
        handler1.next_handler { |request| request.even? ? request : nil }

        expect(handler1.handle(21)).to be_nil
      end
    end
  end
end
