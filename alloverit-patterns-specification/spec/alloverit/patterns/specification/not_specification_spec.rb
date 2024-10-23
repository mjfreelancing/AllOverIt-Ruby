# frozen_string_literal: true

module AllOverIt
  module Patterns
    module Specification
      RSpec.describe NotSpecification do
        let(:true_spec) { TrueSpecification.new }
        let(:false_spec) { FalseSpecification.new }
        let(:candidate) { "any candidate" }

        describe "inheritance hierarchy" do
          it "inherits from CompositeSpecification" do
            expect(NotSpecification).to be < CompositeSpecification
          end
        end

        describe "#satisfied_by?" do
          it "returns true if the specification is not satisfied" do
            result = false_spec.not.satisfied_by?(candidate)
            expect(result).to be(true)
          end

          it "returns false if the specification is satisfied" do
            result = true_spec.not.satisfied_by?(candidate)
            expect(result).to be(false)
          end
        end

        describe "#to_s" do
          it "returns the string representation of the specification" do
            expect(true_spec.to_s).to be("true")
            expect(true_spec.not.to_s).to eq("not (true)")
          end
        end
      end
    end
  end
end
