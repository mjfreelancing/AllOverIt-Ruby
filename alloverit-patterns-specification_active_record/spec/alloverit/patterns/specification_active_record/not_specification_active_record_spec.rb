# frozen_string_literal: true

require "spec_helper"
require_relative "../../../support/widget_name_is_specification"
require_relative "../../../support/widget_value_is_specification"
require_relative "../../../support/bad_specification_active_record"

SpecificationActiveRecord = AllOverIt::Patterns::SpecificationActiveRecord

RSpec.describe AllOverIt::Patterns::SpecificationActiveRecord::NotSpecificationActiveRecord do
  before do
    Widget.create!(name: "foo", value: 1)
    Widget.create!(name: "bar", value: 2)
    Widget.create!(name: "foo", value: 3)
  end

  let(:foo_spec) { WidgetNameIsSpecification.new("foo") }
  let(:bar_spec) { WidgetNameIsSpecification.new("bar") }
  let(:value_1_spec) { WidgetValueIsSpecification.new(1) }

  describe "inheritance hierarchy" do
    it "inherits from CompositeSpecificationActiveRecord" do
      expect(described_class).to be < AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord
    end
  end

  describe "#initialize" do
    context "when other is not a valid SpecificationActiveRecord" do
      it "raises ArgumentError" do
        expect {
          foo_spec.not.and(BadSpecificationActiveRecord.new)
        }.to raise_error(
          ArgumentError,
          "Expected #{BadSpecificationActiveRecord.name} to include #{SpecificationActiveRecord.name}"
        )
      end
    end
  end

  describe "#satisfied_by?" do
    it "returns true if the specification is not satisfied" do
      widget = Widget.find_by(name: "bar")
      expect(foo_spec.not.satisfied_by?(widget)).to be(true)
    end

    it "returns false if the specification is satisfied" do
      widget = Widget.find_by(name: "foo")
      expect(foo_spec.not.satisfied_by?(widget)).to be(false)
    end

    it "returns true if value is not 1" do
      widget = Widget.find_by(name: "bar", value: 2)
      expect(value_1_spec.not.satisfied_by?(widget)).to be(true)
    end

    it "returns false if value is 1" do
      widget = Widget.find_by(name: "foo", value: 1)
      expect(value_1_spec.not.satisfied_by?(widget)).to be(false)
    end
  end

  describe "#to_scope" do
    it "returns widgets not matching the specification" do
      spec = foo_spec.not
      result = spec.to_scope(Widget.all)
      expect(result.pluck(:name)).to include("bar")
      expect(result.pluck(:name)).not_to include("baz")
    end

    it "returns all widgets if negating a spec that matches none" do
      spec = WidgetNameIsSpecification.new("baz").not
      result = spec.to_scope(Widget.all)
      expect(result.count).to eq(3)
    end

    it "returns widgets not matching value 1" do
      spec = value_1_spec.not
      result = spec.to_scope(Widget.all)      
      expect(result.pluck(:value)).not_to include(1)
    end
  end
end
