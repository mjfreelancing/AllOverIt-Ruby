# frozen_string_literal: true

require "rspec"

require_relative "../../../../lib/alloverit/patterns/specification/specification"
require_relative "../../../../lib/alloverit/patterns/specification/composite_specification"
require_relative "../../../../lib/alloverit/patterns/specification/or_specification"

module AllOverIt
  module Patterns
    module Specification
      module OrSpecificationFixture
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

        RSpec.describe Alloverit::Patterns::Specification::OrSpecification do
          let(:true_spec) { TrueSpecification.new }
          let(:false_spec) { FalseSpecification.new }
          let(:candidate) { "any candidate" }

          describe "#satisfied_by?" do
            context "when left side is class" do
              it "returns true if the left specification is satisfied" do
                result = TrueSpecification.or(false_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns true if the right specification is satisfied" do
                result = FalseSpecification.or(true_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns false if neither specification is satisfied" do
                result = FalseSpecification.or(false_spec).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if both specification are satisfied" do
                result = TrueSpecification.or(true_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end

            context "when right side is class" do
              it "returns true if the left specification is satisfied" do
                result = true_spec.or(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns true if the right specification is satisfied" do
                result = false_spec.or(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns false if neither specification is satisfied" do
                result = false_spec.or(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if both specification are satisfied" do
                result = true_spec.or(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end

            context "when both sides are classes" do
              it "returns true if the left specification is satisfied" do
                result = TrueSpecification.or(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns true if the right specification is satisfied" do
                result = FalseSpecification.or(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns false if neither specification is satisfied" do
                result = FalseSpecification.or(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if both specification are satisfied" do
                result = TrueSpecification.or(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end

            context "when both sides are instances" do
              it "returns true if the left specification is satisfied" do
                result = true_spec.or(false_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns true if the right specification is satisfied" do
                result = false_spec.or(true_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns false if neither specification is satisfied" do
                result = false_spec.or(false_spec).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if both specification are satisfied" do
                result = true_spec.or(true_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end
          end
        end
      end
    end
  end
end
