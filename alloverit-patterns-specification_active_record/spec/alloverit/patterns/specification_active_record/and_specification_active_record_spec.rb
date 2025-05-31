# frozen_string_literal: true

require "spec_helper"
require_relative "../../../support/widget_name_is_specification"
require_relative "../../../support/widget_value_is_specification"
require_relative "../../../support/bad_specification_active_record"

SpecificationActiveRecord = AllOverIt::Patterns::SpecificationActiveRecord

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      RSpec.describe AndSpecificationActiveRecord do
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

        describe "#to_s" do
          it "returns the expected string representation for AND" do
            spec = foo_spec.and(value_1_spec)
            expect(spec.to_s).to eq("(name = foo AND value = 1)")
          end

          it "returns the expected string representation for AND with different specs" do
            spec = bar_spec.and(value_2_spec)
            expect(spec.to_s).to eq("(name = bar AND value = 2)")
          end
        end

        describe "#to_arel" do
          let(:arel_table) { Widget.arel_table }

          it "returns an AND Arel node for two specs" do
            spec = foo_spec.and(value_1_spec)
            arel = spec.to_arel(arel_table)

            expect(arel.to_sql).to include("AND")
            expect(arel.to_sql).to include("foo")
            expect(arel.to_sql).to include("1")
          end

          it "returns an AND Arel node for different specs" do
            spec = bar_spec.and(value_2_spec)
            arel = spec.to_arel(arel_table)

            expect(arel.to_sql).to include("AND")
            expect(arel.to_sql).to include("bar")
            expect(arel.to_sql).to include("2")
          end
        end

        describe 'deep and nested composition' do
          it 'handles AND nested with OR and NOT' do
            # (name = foo AND (value = 2 OR NOT name = bar))
            nested_spec = foo_spec.and(value_2_spec.or(bar_spec.not))
            result = nested_spec.to_scope(Widget.all)

            expect(result.pluck(:name)).to include('foo')
            expect(result.pluck(:value)).to include(1, 3)
          end
          it 'handles multiple levels of nesting' do
            # ((name = foo AND value = 1) OR (value = 2 AND name = bar))
            left = foo_spec.and(value_1_spec)
            right = value_2_spec.and(bar_spec)
            deep_spec = left.or(right)
            result = deep_spec.to_scope(Widget.all)

            expect(result).to be_a(ActiveRecord::Relation)
            expect(result.pluck(:name)).to include('foo', 'bar')
            expect(result.pluck(:value)).to include(1, 2)
          end
        end

        describe 'invalid input to all combinators' do
          let(:bad_spec) { Class.new.new }

          it 'raises ArgumentError for and' do
            expect { foo_spec.and(bad_spec) }.to raise_error(ArgumentError)
          end
          it 'raises ArgumentError for and_not' do
            expect { foo_spec.and_not(bad_spec) }.to raise_error(ArgumentError)
          end
          it 'raises ArgumentError for or' do
            expect { foo_spec.or(bad_spec) }.to raise_error(ArgumentError)
          end
          it 'raises ArgumentError for or_not' do
            expect { foo_spec.or_not(bad_spec) }.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end
