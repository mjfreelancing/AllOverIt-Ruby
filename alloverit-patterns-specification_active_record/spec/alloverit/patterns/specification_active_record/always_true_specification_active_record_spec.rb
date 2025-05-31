# frozen_string_literal: true

require "spec_helper"
require "alloverit/patterns/specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      RSpec.describe AlwaysTrueSpecificationActiveRecord do
        let(:spec) { described_class.new }

        describe "inheritance" do
          it "inherits from CompositeSpecificationActiveRecord" do
            expect(spec).to be_a(AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord)
          end
        end

        describe "#satisfied_by?" do
          it "always returns true" do
            expect(spec.satisfied_by?(true)).to be true
            expect(spec.satisfied_by?(false)).to be true
            expect(spec.satisfied_by?(nil)).to be true
            expect(spec.satisfied_by?(Object.new)).to be true
          end
        end

        describe "#to_arel" do
          it "returns an Arel node that always evaluates to true" do
            arel = spec.to_arel(nil)
            expect(arel.to_s).to match(/1 ?= ?1/) # Accepts 1=1 or 1 = 1
          end
        end

        describe "#to_s" do
          it "returns 'true'" do
            expect(spec.to_s).to eq("true")
          end
        end
      end
    end
  end
end
