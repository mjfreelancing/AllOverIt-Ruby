# frozen_string_literal: true

require_relative "../../support/widget_name_is_specification"
require_relative "../../support/widget_value_is_specification"
require_relative "../../../lib/alloverit/patterns/specification_active_record/always_true_specification_active_record"
require_relative "../../../lib/alloverit/patterns/specification_active_record/always_false_specification_active_record"

module AllOverIt
  module Patterns
    RSpec.describe SpecificationActiveRecord do
      let(:spec) { WidgetValueIsSpecification.new(1) }

      describe "#and" do
        it "returns an AndSpecificationActiveRecord when provided another specification class" do
          result = spec.and(WidgetNameIsSpecification.new("foo"))
          expect(result).to be_an_instance_of(AllOverIt::Patterns::SpecificationActiveRecord::AndSpecificationActiveRecord)
        end
      end

      describe "#and_not" do
        it "returns an AndNotSpecificationActiveRecord when provided another specification class" do
          result = spec.and_not(WidgetNameIsSpecification.new("foo"))
          expect(result).to be_an_instance_of(AllOverIt::Patterns::SpecificationActiveRecord::AndNotSpecificationActiveRecord)
        end
      end

      describe "#or" do
        it "returns an OrSpecificationActiveRecord when provided another specification class" do
          result = spec.or(WidgetNameIsSpecification.new("foo"))
          expect(result).to be_an_instance_of(AllOverIt::Patterns::SpecificationActiveRecord::OrSpecificationActiveRecord)
        end
      end

      describe "#or_not" do
        it "returns an OrNotSpecificationActiveRecord when provided another specification class" do
          result = spec.or_not(WidgetNameIsSpecification.new("foo"))
          expect(result).to be_an_instance_of(AllOverIt::Patterns::SpecificationActiveRecord::OrNotSpecificationActiveRecord)
        end
      end

      describe "#not" do
        it "returns a NotSpecificationActiveRecord instance" do
          result = spec.not
          expect(result).to be_an_instance_of(AllOverIt::Patterns::SpecificationActiveRecord::NotSpecificationActiveRecord)
        end
      end

      describe "abstract method enforcement" do
        # Use an anonymous class with only the module included to test abstract method enforcement in isolation.
        # This ensures the test is not affected by any other class logic or inheritance, and directly exercises
        # the module's abstract method requirements.
        let(:base) { Class.new { include AllOverIt::Patterns::SpecificationActiveRecord }.new }

        it "raises NotImplementedError for satisfied_by?" do
          expect { base.satisfied_by?(:foo) }.to raise_error(NotImplementedError, /implement #satisfied_by\?/)
        end

        it "raises NotImplementedError for to_arel" do
          expect { base.to_arel(double("table")) }.to raise_error(NotImplementedError, /implement #to_arel/)
        end

        it "raises NotImplementedError for to_s" do
          expect { base.to_s }.to raise_error(NotImplementedError, /implement #to_s/)
        end
      end

      describe ".always_false" do
        it "returns a new instance each time for always_false" do
          expect(SpecificationActiveRecord.always_false).not_to be(SpecificationActiveRecord.always_false)
        end

        it "returns the correct class for always_false" do
          expect(SpecificationActiveRecord.always_false.class.name).to match(/AlwaysFalseSpecificationActiveRecord/)
        end
      end

      describe ".always_true" do
        it "returns a new instance each time for always_true" do
          expect(SpecificationActiveRecord.always_true).not_to be(SpecificationActiveRecord.always_true)
        end

        it "returns the correct class for always_true" do
          expect(SpecificationActiveRecord.always_true.class.name).to match(/AlwaysTrueSpecificationActiveRecord/)
        end
      end
    end
  end
end
