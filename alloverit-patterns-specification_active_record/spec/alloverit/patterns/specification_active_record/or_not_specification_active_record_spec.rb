# frozen_string_literal: true

require "spec_helper"
require_relative "../../../support/widget_name_is_specification"
require_relative "../../../support/widget_value_is_specification"
require_relative "../../../support/bad_specification_active_record"

SpecificationActiveRecord = AllOverIt::Patterns::SpecificationActiveRecord

RSpec.describe AllOverIt::Patterns::SpecificationActiveRecord::OrNotSpecificationActiveRecord do
  before do
    Widget.create!(name: "foo", value: 1)
    Widget.create!(name: "bar", value: 2)
    Widget.create!(name: "foo", value: 3)
  end

  let(:foo_spec) { WidgetNameIsSpecification.new("foo") }
  let(:bar_spec) { WidgetNameIsSpecification.new("bar") }
  let(:value_1_spec) { WidgetValueIsSpecification.new(1) }
  let(:value_2_spec) { WidgetValueIsSpecification.new(2) }

  describe "inheritance hierarchy" do
    it "inherits from CompositeSpecificationActiveRecord" do
      expect(described_class).to be < AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord
    end
  end

  describe "#initialize" do
    context "when other is not a valid SpecificationActiveRecord" do
      it "raises ArgumentError" do
        expect {
          foo_spec.or_not(BadSpecificationActiveRecord.new)
        }.to raise_error(
          ArgumentError,
          "Expected #{BadSpecificationActiveRecord.name} to include #{SpecificationActiveRecord.name}"
        )
      end
    end
  end

  describe "#satisfied_by?" do
    it "returns true if name is satisfied or value is not satisfied" do
      widget = Widget.find_by(name: "foo", value: 1)      
      expect(foo_spec.or_not(value_2_spec).satisfied_by?(widget)).to be(true)
    end

    it "returns false if name is not satisfied and value is satisfied" do
      widget = Widget.find_by(name: "bar", value: 2)
      expect(foo_spec.or_not(value_2_spec).satisfied_by?(widget)).to be(false)
    end

    it "returns true if neither is satisfied" do
      widget = Widget.new(name: "baz")
      expect(foo_spec.or_not(bar_spec).satisfied_by?(widget)).to be(true)
    end

    it "returns true if both are satisfied" do
      widget = Widget.find_by(name: "foo")
      expect(foo_spec.or_not(foo_spec).satisfied_by?(widget)).to be(true)
    end
  end

  describe "#to_scope" do
    it "returns widgets matching name 'foo' or not value 2" do
      spec = foo_spec.or_not(value_2_spec)
      result = spec.to_scope(Widget.all)
      expect(result.pluck(:name)).to include("foo")
      expect(result.pluck(:value)).not_to include(2)
    end

    it "returns all widgets if neither matches" do
      spec = WidgetNameIsSpecification.new("baz").or_not(WidgetNameIsSpecification.new("qux"))
      result = spec.to_scope(Widget.all)
      expect(result.count).to eq(3)
    end
  end
end
