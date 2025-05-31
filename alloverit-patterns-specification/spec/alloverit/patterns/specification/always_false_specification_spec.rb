# frozen_string_literal: true

require "alloverit/patterns/specification"

module AllOverIt
  module Patterns
    module Specification
      RSpec.describe AlwaysFalseSpecification do
        let(:spec) { described_class.new }

        describe "inheritance" do
          it "inherits from CompositeSpecification" do
            expect(spec).to be_a(AllOverIt::Patterns::Specification::CompositeSpecification)
          end
        end

        describe "#satisfied_by?" do
          it "always returns false" do
            expect(spec.satisfied_by?(true)).to be false
            expect(spec.satisfied_by?(false)).to be false
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
