# frozen_string_literal: true

require_relative "../../../../lib/alloverit/patterns/specification/specification"
require_relative "../../../../lib/alloverit/patterns/specification/and_specification"

module AllOverIt
  module Patterns
    module Specification
      module SpecificationFixture
        Specification = Alloverit::Patterns::Specification

        class DummyBadImplementationSpecification
          include Specification
        end

        class DummySpecification
          include Specification

          def satisfied_by?(candidate)
            true
          end
        end

        AndSpecification = Alloverit::Patterns::Specification::AndSpecification
        AndNotSpecification = Alloverit::Patterns::Specification::AndNotSpecification
        OrSpecification = Alloverit::Patterns::Specification::OrSpecification
        OrNotSpecification = Alloverit::Patterns::Specification::OrNotSpecification
        NotSpecification = Alloverit::Patterns::Specification::NotSpecification

        RSpec.describe Alloverit::Patterns::Specification do
          let(:spec) { DummySpecification.new }

          describe "#satisfied_by?" do
            let(:spec) { DummyBadImplementationSpecification.new }

            it "raises NotImplementedError when #satisfied_by? not implemented" do
              expect { spec.satisfied_by?(double) }.to raise_error(NotImplementedError, "You must implement #satisfied_by?")
            end
          end

          describe "#and" do
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
            it "returns a NotSpecification instance" do
              result = spec.not
              expect(result).to be_an_instance_of(NotSpecification)
            end
          end
        end
      end
    end
  end
end
