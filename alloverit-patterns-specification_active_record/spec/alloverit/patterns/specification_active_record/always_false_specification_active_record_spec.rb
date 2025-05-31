# frozen_string_literal: true

require "spec_helper"
require "alloverit/patterns/specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      RSpec.describe AlwaysFalseSpecificationActiveRecord do
        let(:spec) { described_class.new }

        describe "inheritance" do
          it "inherits from CompositeSpecificationActiveRecord" do
            expect(spec).to be_a(AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord)
          end
        end

        describe "#satisfied_by?" do
          it "always returns false" do
            expect(spec.satisfied_by?(true)).to be false
            expect(spec.satisfied_by?(false)).to be false
            expect(spec.satisfied_by?(nil)).to be false
            expect(spec.satisfied_by?(Object.new)).to be false
          end
        end

        describe "#to_arel" do
          it "returns an Arel node that always evaluates to false" do
            arel = spec.to_arel(nil)
            expect(arel.to_s).to match(/1 ?= ?0/) # Accepts 1=0 or 1 = 0
          end
        end

        describe "#to_s" do
          it "returns 'false'" do
            expect(spec.to_s).to eq("false")
          end
        end
      end
    end
  end
end
