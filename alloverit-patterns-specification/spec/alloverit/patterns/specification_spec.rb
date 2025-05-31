# frozen_string_literal: true

module AllOverIt
  module Patterns
    module Specification
      RSpec.describe Specification do
        let(:spec) { DummySpecification.new }

        describe "#satisfied_by?" do
          let(:spec) { DummyBadImplementationSpecification.new }

          it "raises NotImplementedError when #satisfied_by? not implemented" do
            expect { spec.satisfied_by?(double) }.to(
              raise_error(NotImplementedError, "You must implement #satisfied_by?")
            )
          end
        end

        describe "#and" do
          it "returns an AndSpecification from a class specification and another specification instance" do
            result = TrueSpecification.and(spec)
            expect(result).to be_an_instance_of(AndSpecification)
          end

          it "returns an AndSpecification when provided another specification instance" do
            other = DummySpecification.new
            result = spec.and(other)
            expect(result).to be_an_instance_of(AndSpecification)
          end

          it "returns an AndSpecification when provided another specification class" do
            result = spec.and(DummySpecification)
            expect(result).to be_an_instance_of(AndSpecification)
          end
        end

        describe "#and_not" do
          it "returns an AndNotSpecification from a class specification and another specification instance" do
            result = TrueSpecification.and_not(spec)
            expect(result).to be_an_instance_of(AndNotSpecification)
          end

          it "returns an AndNotSpecification when provided another specification instance" do
            other = DummySpecification.new
            result = spec.and_not(other)
            expect(result).to be_an_instance_of(AndNotSpecification)
          end

          it "returns an AndNotSpecification when provided another specification class" do
            result = spec.and_not(DummySpecification)
            expect(result).to be_an_instance_of(AndNotSpecification)
          end
        end

        describe "#or" do
          it "returns an OrSpecification from a class specification and another specification instance" do
            result = TrueSpecification.or(spec)
            expect(result).to be_an_instance_of(OrSpecification)
          end

          it "returns an OrSpecification when provided another specification instance" do
            other = DummySpecification.new
            result = spec.or(other)
            expect(result).to be_an_instance_of(OrSpecification)
          end

          it "returns an OrSpecification when provided another specification class" do
            result = spec.or(DummySpecification)
            expect(result).to be_an_instance_of(OrSpecification)
          end
        end

        describe "#or_not" do
          it "returns an OrNotSpecification from a class specification and another specification instance" do
            result = TrueSpecification.or_not(spec)
            expect(result).to be_an_instance_of(OrNotSpecification)
          end

          it "returns an OrNotSpecification when provided another specification instance" do
            other = DummySpecification.new
            result = spec.or_not(other)
            expect(result).to be_an_instance_of(OrNotSpecification)
          end

          it "returns an OrNotSpecification when provided another specification class" do
            result = spec.or_not(DummySpecification)
            expect(result).to be_an_instance_of(OrNotSpecification)
          end
        end

        describe "#not" do
          it "returns a NotSpecification from a class specification" do
            result = TrueSpecification.not
            expect(result).to be_an_instance_of(NotSpecification)
          end

          it "returns a NotSpecification instance" do
            result = spec.not
            expect(result).to be_an_instance_of(NotSpecification)
          end
        end

        describe "#to_s?" do
          let(:spec) { DummyBadImplementationSpecification.new }

          it "raises NotImplementedError when #to_s not implemented" do
            expect { spec.to_s }.to(
              raise_error(NotImplementedError, "You must implement #to_s")
            )
          end
        end

        describe ".always_true" do
          it "returns the same singleton instance for true" do
            expect(Specification.always_true).to be(Specification.always_true)
          end

          it "returns the correct class for true" do
            expect(Specification.always_true.class.name).to match(/AlwaysTrueSpecification/)
          end

          describe "#satisfied_by?" do
            it "always returns true" do
              expect(Specification.always_true.satisfied_by?(true)).to be true
              expect(Specification.always_true.satisfied_by?(false)).to be true
            end
          end

          describe "#to_s" do
            it "returns 'true'" do
              expect(Specification.always_true.to_s).to eq("true")
            end
          end
        end

        describe ".always_false" do
          it "returns the same singleton instance for false" do
            expect(Specification.always_false).to be(Specification.always_false)
          end

          it "returns the correct class for false" do
            expect(Specification.always_false.class.name).to match(/AlwaysFalseSpecification/)
          end

          describe "#satisfied_by?" do
            it "always returns false" do
              expect(Specification.always_false.satisfied_by?(true)).to be false
              expect(Specification.always_false.satisfied_by?(false)).to be false
            end
          end

          describe "#to_s" do
            it "returns 'false'" do
              expect(Specification.always_false.to_s).to eq("false")
            end
          end
        end
      end
    end
  end
end
