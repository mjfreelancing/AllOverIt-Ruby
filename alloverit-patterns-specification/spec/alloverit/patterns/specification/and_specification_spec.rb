# frozen_string_literal: true

module AllOverIt
  module Patterns
    module Specification
      RSpec.describe AndSpecification do
        let(:true_spec) { TrueSpecification.new }
        let(:false_spec) { FalseSpecification.new }
        let(:candidate) { "any candidate" }

        describe "inheritance hierarchy" do
          it "inherits from CompositeSpecification" do
            expect(AndSpecification).to be < CompositeSpecification
          end
        end

        describe "#initialize" do
          context "when other is not a CompositeSpecification" do
            it "raises ArgumentError" do
              expect { TrueSpecification.and(BadSpecification.new) }.to(
                raise_error(
                  ArgumentError,
                  "Expected #{BadSpecification.name} to include #{Specification.name}"
                )
              )
            end
          end
        end

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

        describe "#to_s" do
          it "returns the string representation of the specification" do
            expect(true_spec.to_s).to be("true")
            expect(true_spec.and(false_spec).to_s).to eq("(true and false)")
          end
        end
      end
    end
  end
end
