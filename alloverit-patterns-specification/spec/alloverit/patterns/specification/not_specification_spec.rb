# frozen_string_literal: true

require "rspec"

module Alloverit
  module Patterns
    module Specification
      module NotSpecificationFixture
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
        end
      end
    end
  end
end
