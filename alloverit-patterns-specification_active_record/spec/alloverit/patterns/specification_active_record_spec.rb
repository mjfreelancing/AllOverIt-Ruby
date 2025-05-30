# frozen_string_literal: true

require_relative "../../support/widget_name_is_specification"
require_relative "../../support/widget_value_is_specification"

RSpec.describe AllOverIt::Patterns::SpecificationActiveRecord do
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
end
