# frozen_string_literal: true

require "spec_helper"
require_relative "../../../support/widget_name_is_specification"
require_relative "../../../support/widget_value_is_specification"
require_relative "../../../support/bad_specification_active_record"

SpecificationActiveRecord = AllOverIt::Patterns::SpecificationActiveRecord

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      RSpec.describe NotSpecificationActiveRecord do
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

        describe "#to_s" do
          it "returns the expected string representation for NOT" do
            spec = foo_spec.not
            expect(spec.to_s).to eq("(NOT name = foo)")
          end

          it "returns the expected string representation for NOT with a different spec" do
            spec = value_1_spec.not
            expect(spec.to_s).to eq("(NOT value = 1)")
          end
        end

        describe '#to_arel' do
          let(:arel_table) { Widget.arel_table }
          it 'returns a NOT Arel node for a spec' do
            spec = foo_spec.not
            arel = spec.to_arel(arel_table)

            expect(arel.to_sql).to include('NOT')
            expect(arel.to_sql).to include('foo')
          end
          it 'returns a NOT Arel node for a different spec' do
            spec = value_1_spec.not
            arel = spec.to_arel(arel_table)

            expect(arel.to_sql).to include('NOT')
            expect(arel.to_sql).to include('1')
          end
        end

        describe 'deep and nested composition' do
          it 'handles NOT nested with AND and OR' do
            # NOT (name = foo AND (value = 2 OR name = bar))
            nested_spec = foo_spec.and(value_2_spec.or(bar_spec)).not
            result = nested_spec.to_scope(Widget.all)

            expect(result).to be_a(ActiveRecord::Relation)
            expect(result.pluck(:name)).to include('bar', 'foo')
          end
          it 'handles multiple levels of nesting' do
            # NOT ((name = foo OR value = 2) AND (value = 1 OR name = bar))
            left = foo_spec.or(value_2_spec)
            right = value_1_spec.or(bar_spec)
            deep_spec = left.and(right).not
            result = deep_spec.to_scope(Widget.all)

            expect(result).to be_a(ActiveRecord::Relation)
            expect(result.pluck(:name)).to eq(['foo'])
            expect(result.pluck(:value)).to eq([3])
          end
        end

        describe 'invalid input to all combinators' do
          let(:bad_spec) { Class.new.new }

          it 'raises ArgumentError for and' do
            expect { foo_spec.not.and(bad_spec) }.to raise_error(ArgumentError)
          end

          it 'raises ArgumentError for and_not' do
            expect { foo_spec.not.and_not(bad_spec) }.to raise_error(ArgumentError)
          end

          it 'raises ArgumentError for or' do
            expect { foo_spec.not.or(bad_spec) }.to raise_error(ArgumentError)
          end

          it 'raises ArgumentError for or_not' do
            expect { foo_spec.not.or_not(bad_spec) }.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end
