# frozen_string_literal: true

require "rspec"

module Alloverit
  module Patterns
    module Specification
      module OrSpecificationFixture
        RSpec.describe OrSpecification do
          let(:true_spec) { TrueSpecification.new }
          let(:false_spec) { FalseSpecification.new }
          let(:candidate) { "any candidate" }

          describe "initialization" do
            describe "when other is not a CompositeSpecification" do
              it "raises ArgumentError" do
                expect { TrueSpecification.or(BadSpecification.new) }.to(
                  raise_error(
                    ArgumentError,
                    "Expected an instance of #{CompositeSpecification.name}, got #{BadSpecification.name}")
                )
              end
            end
          end

          describe "inheritance hierarchy" do
            it "inherits from CompositeSpecification" do
              expect(OrSpecification).to be < CompositeSpecification
            end
          end

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
