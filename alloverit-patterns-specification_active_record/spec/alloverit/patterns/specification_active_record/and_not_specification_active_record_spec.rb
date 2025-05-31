# frozen_string_literal: true

require "spec_helper"
require_relative "../../../support/widget_name_is_specification"
require_relative "../../../support/widget_value_is_specification"
require_relative "../../../support/bad_specification_active_record"

SpecificationActiveRecord = AllOverIt::Patterns::SpecificationActiveRecord

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      RSpec.describe AndNotSpecificationActiveRecord do
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
                foo_spec.and_not(BadSpecificationActiveRecord.new)
              }.to raise_error(
                ArgumentError,
                "Expected #{BadSpecificationActiveRecord.name} to include #{SpecificationActiveRecord.name}"
              )
            end
          end
        end

        describe "#satisfied_by?" do
          it "returns true if name is 'foo' and value is not 2" do
            widget = Widget.find_by(name: "foo", value: 1)
            expect(foo_spec.and_not(value_2_spec).satisfied_by?(widget)).to be true
          end

          it "returns false if name is 'foo' and value is 2" do
            widget = Widget.create!(name: "foo", value: 2)
            expect(foo_spec.and_not(value_2_spec).satisfied_by?(widget)).to be false
          end

          it "returns true if value is 1 and name is not 'bar'" do
            widget = Widget.find_by(name: "foo", value: 1)
            expect(value_1_spec.and_not(bar_spec).satisfied_by?(widget)).to be true
          end

          it "returns false if value is 2 and name is 'bar'" do
            widget = Widget.find_by(name: "bar", value: 2)
            expect(value_2_spec.and_not(bar_spec).satisfied_by?(widget)).to be false
          end
        end

        describe "#to_scope" do
          it "returns widgets matching name 'foo' and not value 2" do
            spec = foo_spec.and_not(value_2_spec)
            result = spec.to_scope(Widget.all)
            expect(result.pluck(:name)).to all(eq("foo"))
            expect(result.pluck(:value)).not_to include(2)
          end

          it "returns widgets matching value 1 and not name 'bar'" do
            spec = value_1_spec.and_not(bar_spec)
            result = spec.to_scope(Widget.all)
            expect(result.pluck(:value)).to all(eq(1))
            expect(result.pluck(:name)).not_to include("bar")
          end

          it "returns empty if no records match" do
            Widget.where(name: "bar").destroy_all
            spec = bar_spec.and_not(foo_spec)
            expect(spec.to_scope(Widget.all)).to be_empty
          end
        end

        describe "#to_s" do
          it "returns the expected string representation for AND NOT" do
            spec = foo_spec.and_not(value_2_spec)
            expect(spec.to_s).to eq("(name = foo AND NOT value = 2)")
          end

          it "returns the expected string representation for AND NOT with different specs" do
            spec = value_1_spec.and_not(bar_spec)
            expect(spec.to_s).to eq("(value = 1 AND NOT name = bar)")
          end
        end

        describe '#to_arel' do
          let(:arel_table) { Widget.arel_table }
          it 'returns an AND NOT Arel node for two specs' do
            spec = foo_spec.and_not(value_2_spec)
            arel = spec.to_arel(arel_table)

            expect(arel.to_sql).to include('AND')
            expect(arel.to_sql).to include('NOT')
            expect(arel.to_sql).to include('foo')
            expect(arel.to_sql).to include('2')
          end
          it 'returns an AND NOT Arel node for different specs' do
            spec = value_1_spec.and_not(bar_spec)
            arel = spec.to_arel(arel_table)

            expect(arel.to_sql).to include('AND')
            expect(arel.to_sql).to include('NOT')
            expect(arel.to_sql).to include('1')
            expect(arel.to_sql).to include('bar')
          end
        end

        describe 'deep and nested composition' do
          it 'handles AND NOT nested with OR and NOT' do
            # (name = foo AND NOT (value = 2 OR NOT name = bar))
            nested_spec = foo_spec.and_not(value_2_spec.or(bar_spec.not))
            result = nested_spec.to_scope(Widget.all)

            # Should include widgets named 'foo' and not value 2 or not name 'bar'
            expect(result.pluck(:name)).to all(eq('foo'))
            expect(result.pluck(:value)).not_to include(2)
          end
          it 'handles multiple levels of nesting' do
            # ((name = foo AND NOT value = 2) OR (value = 1 AND NOT name = bar))
            left = foo_spec.and_not(value_2_spec)
            right = value_1_spec.and_not(bar_spec)
            deep_spec = left.or(right)
            result = deep_spec.to_scope(Widget.all)

            expect(result).to be_a(ActiveRecord::Relation)
            # Should include widgets named 'foo' (not value 2) or value 1 (not name bar)
            expect(result.pluck(:name)).to include('foo')
            expect(result.pluck(:value)).to include(1)
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
