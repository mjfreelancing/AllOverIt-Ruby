# frozen_string_literal: true

require "spec_helper"
require_relative "../../../support/widget_name_is_specification"
require_relative "../../../support/widget_value_is_specification"
require_relative "../../../support/bad_specification_active_record"

SpecificationActiveRecord = AllOverIt::Patterns::SpecificationActiveRecord

RSpec.describe AllOverIt::Patterns::SpecificationActiveRecord::AndSpecificationActiveRecord do
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
          foo_spec.and(BadSpecificationActiveRecord.new)
        }.to raise_error(
          ArgumentError,
          "Expected #{BadSpecificationActiveRecord.name} to include #{SpecificationActiveRecord.name}"
        )
      end
    end
  end

  describe "#satisfied_by?" do
    it "returns true if both name and value specifications are satisfied" do
      widget = Widget.find_by(name: "foo", value: 1)
      expect(foo_spec.and(value_1_spec).satisfied_by?(widget)).to be(true)
    end

    it "returns false if name is satisfied but value is not" do
      widget = Widget.find_by(name: "foo", value: 3)
      expect(foo_spec.and(value_2_spec).satisfied_by?(widget)).to be(false)
    end

    it "returns false if value is satisfied but name is not" do
      widget = Widget.find_by(name: "bar", value: 2)
      expect(bar_spec.and(value_1_spec).satisfied_by?(widget)).to be(false)
    end
  end

  describe "#to_scope" do
    it "returns widgets matching both name 'foo' and value 1" do
      spec = foo_spec.and(value_1_spec)
      result = spec.to_scope(Widget.all)
      expect(result.pluck(:name)).to all(eq("foo"))
      expect(result.pluck(:value)).to all(eq(1))
    end

    it "returns no widgets if no record matches both name and value" do
      spec = foo_spec.and(bar_spec)
      expect(spec.to_scope(Widget.all)).to be_empty
    end
  end
end
