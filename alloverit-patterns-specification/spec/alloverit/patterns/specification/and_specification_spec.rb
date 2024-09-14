# frozen_string_literal: true

require "rspec"

require_relative "../../../../lib/alloverit/patterns/specification/specification"
require_relative "../../../../lib/alloverit/patterns/specification/composite_specification"
require_relative "../../../../lib/alloverit/patterns/specification/and_specification"

module AllOverIt
  module Patterns
    module Specification
      module AndSpecification
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

        RSpec.describe Alloverit::Patterns::Specification::AndSpecification do
          let(:true_spec) { TrueSpecification.new }
          let(:false_spec) { FalseSpecification.new }
          let(:candidate) { "any candidate" }

          describe "#satisfied_by?" do
            context "when left side is class" do
              it "returns false if the left specification is satisfied" do
                result = TrueSpecification.and(false_spec).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns false if the right specification is satisfied" do
                result = FalseSpecification.and(true_spec).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns false if neither specification is satisfied" do
                result = FalseSpecification.and(false_spec).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if both specification are satisfied" do
                result = TrueSpecification.and(true_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end

            context "when right side is class" do
              it "returns false if the left specification is satisfied" do
                result = true_spec.and(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns false if the right specification is satisfied" do
                result = false_spec.and(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns false if neither specification is satisfied" do
                result = false_spec.and(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if both specification are satisfied" do
                result = true_spec.and(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end

            context "when both sides are classes" do
              it "returns false if the left specification is satisfied" do
                result = TrueSpecification.and(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns false if the right specification is satisfied" do
                result = FalseSpecification.and(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns false if neither specification is satisfied" do
                result = FalseSpecification.and(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if both specification are satisfied" do
                result = TrueSpecification.and(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end

            context "when both sides are instances" do
              it "returns false if the left specification is satisfied" do
                result = true_spec.and(false_spec).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns false if the right specification is satisfied" do
                result = false_spec.and(true_spec).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns false if neither specification is satisfied" do
                result = false_spec.and(false_spec).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if both specification are satisfied" do
                result = true_spec.and(true_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end
          end
        end
      end
    end
  end
end
