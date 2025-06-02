# frozen_string_literal: true

require "active_record"
require "sqlite3"
require "active_support/concern"
require_relative "../../../../lib/alloverit/patterns/specification_active_record/specification_scopeable"
require_relative "../../../support/widget"
require_relative "../../../support/widget_name_is_specification"
require_relative "../../../support/widget_value_is_specification"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      RSpec.describe SpecificationScopeable do
        before(:each) do
          Widget.delete_all
          Widget.create!(name: "foo", value: 1)
          Widget.create!(name: "bar", value: 2)
          Widget.create!(name: "baz", value: 2)
          Widget.create!(name: "foo", value: 3)
        end

        let(:name_spec) { WidgetNameIsSpecification.new("foo") }
        let(:value_spec) { WidgetValueIsSpecification.new(2) }

        # This test is only included to ensure that the instance method is included in the coverage report.
        # Despite being called in other tests, it is not being capture by the coverage report.
        it "calls the instance method directly" do
          dummy = Class.new do
            include AllOverIt::Patterns::SpecificationActiveRecord::SpecificationScopeable
          end.new

          spec = double("spec")
          expect(spec).to receive(:to_scope).with(dummy)
          dummy.scoped_to(spec)
        end

        describe ".scoped_to" do
          it "returns only widgets with the specified name" do
            results = Widget.scoped_to(name_spec).pluck(:name)
            expect(results).to match_array(%w[foo foo])
          end

          it "returns only widgets with the specified value" do
            results = Widget.scoped_to(value_spec).pluck(:value)
            expect(results).to match_array([2, 2])
          end

          it "delegates to specification.to_scope with all for class method" do
            spec = double("spec")
            expect(spec).to receive(:to_scope).with(Widget.all)
            Widget.scoped_to(spec)
          end
        end

        describe "#scoped_to" do
          it "can be chained from a relation" do
            results = Widget.where(name: "bar").scoped_to(value_spec).pluck(:name, :value)
            expect(results).to eq([["bar", 2]])
          end

          it "delegates to specification.to_scope with self for instance method" do
            spec = double("spec")
            relation = Widget.where(name: "foo")
            expect(spec).to receive(:to_scope).with(relation)
            relation.scoped_to(spec)
          end
        end

        describe "#to_s" do
          it "returns the expected string for class method AND" do
            spec = name_spec.and(value_spec)
            expect(spec.to_s).to eq("(name = foo AND value = 2)")
          end

          it "returns the expected string for class method AND NOT" do
            spec = name_spec.and_not(value_spec)
            expect(spec.to_s).to eq("(name = foo AND NOT value = 2)")
          end

          it "returns the expected string for class method OR" do
            spec = name_spec.or(value_spec)
            expect(spec.to_s).to eq("(name = foo OR value = 2)")
          end

          it "returns the expected string for class method OR NOT" do
            spec = name_spec.or_not(value_spec)
            expect(spec.to_s).to eq("(name = foo OR NOT value = 2)")
          end

          it "returns the expected string for class method NOT" do
            spec = name_spec.not
            expect(spec.to_s).to eq("(NOT name = foo)")
          end
        end

        describe "combinator chaining and deep composition" do
          it "handles chaining of multiple combinators" do
            spec = name_spec.and(value_spec).or(name_spec.not)
            result = Widget.scoped_to(spec)
            expect(result.pluck(:name)).to match_array(%w[bar baz])
          end

          it "handles deep composition" do
            spec = name_spec.and(value_spec.or(name_spec.not))
            result = Widget.scoped_to(spec)
            expect(result).to be_a(ActiveRecord::Relation)
          end
        end

        describe "invalid input to combinators" do
          let(:bad_spec) { Class.new.new }

          it "raises ArgumentError for and" do
            expect { name_spec.and(bad_spec) }.to raise_error(ArgumentError)
          end

          it "raises ArgumentError for and_not" do
            expect { name_spec.and_not(bad_spec) }.to raise_error(ArgumentError)
          end

          it "raises ArgumentError for or" do
            expect { name_spec.or(bad_spec) }.to raise_error(ArgumentError)
          end

          it "raises ArgumentError for or_not" do
            expect { name_spec.or_not(bad_spec) }.to raise_error(ArgumentError)
          end
        end
      end
    end
  end
end
