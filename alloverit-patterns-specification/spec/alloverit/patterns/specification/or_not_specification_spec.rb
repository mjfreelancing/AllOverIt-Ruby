# frozen_string_literal: true

require "rspec"

module Alloverit
  module Patterns
    module Specification
      module OrNotSpecificationFixture
        RSpec.describe OrNotSpecification do
          let(:true_spec) { TrueSpecification.new }
          let(:false_spec) { FalseSpecification.new }
          let(:candidate) { "any candidate" }

          describe "initialization" do
            describe "when other is not a CompositeSpecification" do
              it "raises ArgumentError" do
                expect { TrueSpecification.or_not(BadSpecification.new) }.to(
                  raise_error(
                    ArgumentError,
                    "Expected an instance of #{CompositeSpecification.name}, got #{BadSpecification.name}"
                  )
                )
              end
            end
          end

          describe "inheritance hierarchy" do
            it "inherits from CompositeSpecification" do
              expect(OrNotSpecification).to be < CompositeSpecification
            end
          end

          describe "#satisfied_by?" do
            context "when left side is class" do
              it "returns true if the left specification is satisfied" do
                result = TrueSpecification.or_not(false_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns false if the right specification is satisfied" do
                result = FalseSpecification.or_not(true_spec).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if neither specification is satisfied" do
                result = FalseSpecification.or_not(false_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns true if both specification are satisfied" do
                result = TrueSpecification.or_not(true_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end

            context "when right side is class" do
              it "returns true if the left specification is satisfied" do
                result = true_spec.or_not(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns false if the right specification is satisfied" do
                result = false_spec.or_not(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if neither specification is satisfied" do
                result = false_spec.or_not(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns true if both specification are satisfied" do
                result = true_spec.or_not(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end

            context "when both sides are classes" do
              it "returns true if the left specification is satisfied" do
                result = TrueSpecification.or_not(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns false if the right specification is satisfied" do
                result = FalseSpecification.or_not(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if neither specification is satisfied" do
                result = FalseSpecification.or_not(FalseSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns true if both specification are satisfied" do
                result = TrueSpecification.or_not(TrueSpecification).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end

            context "when both sides are instances" do
              it "returns true if the left specification is satisfied" do
                result = true_spec.or_not(false_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns false if the right specification is satisfied" do
                result = false_spec.or_not(true_spec).satisfied_by?(candidate)
                expect(result).to be(false)
              end

              it "returns true if neither specification is satisfied" do
                result = false_spec.or_not(false_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end

              it "returns true if both specification are satisfied" do
                result = true_spec.or_not(true_spec).satisfied_by?(candidate)
                expect(result).to be(true)
              end
            end
          end
        end
      end
    end
  end
end
