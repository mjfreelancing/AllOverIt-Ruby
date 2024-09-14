# frozen_string_literal: true

require "rspec"

require_relative "../../../../lib/alloverit/patterns/specification/specification"
require_relative "../../../../lib/alloverit/patterns/specification/composite_specification"
require_relative "../../../../lib/alloverit/patterns/specification/not_specification"

module AllOverIt
  module Patterns
    module Specification
      module NotSpecificationFixture
        CompositeSpecification = Alloverit::Patterns::Specification::CompositeSpecification

        class TrueSpecification < CompositeSpecification
          def satisfied_by?(candidate)
            true
          end
        end

        class FalseSpecification < CompositeSpecification
          def satisfied_by?(candidate)
            false
          end
        end

        RSpec.describe Alloverit::Patterns::Specification::NotSpecification do
          let(:true_spec) { TrueSpecification.new }
          let(:false_spec) { FalseSpecification.new }
          let(:candidate) { "any candidate" }

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
