# frozen_string_literal: true

require_relative "../../../lib/alloverit/utils/check"

module AllOverIt
  module Utils
    RSpec.describe Check do
      describe ".not_nil" do
        context "when all arguments are not nil" do
          it "does not raise an error" do
            expect do
              described_class.not_nil(arg1: "value", arg2: 123, arg3: true)
            end.not_to raise_error
          end
        end

        context "when one argument is nil" do
          it "raises an ArgumentError with the argument name" do
            expect do
              described_class.not_nil(arg1: "value", arg2: nil, arg3: 123)
            end.to raise_error(ArgumentError, "arg2 cannot be nil")
          end
        end

        context "when multiple arguments are nil" do
          it "raises an ArgumentError for the first nil argument" do
            expect do
              described_class.not_nil(arg1: nil, arg2: nil, arg3: "value")
            end.to raise_error(ArgumentError, "arg1 cannot be nil")
          end
        end

        context "when no arguments are provided" do
          it "does not raise an error" do
            expect do
              described_class.not_nil
            end.not_to raise_error
          end
        end
      end
    end
  end
end
