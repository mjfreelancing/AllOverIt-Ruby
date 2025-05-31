# frozen_string_literal: true

require "spec_helper"
require "alloverit/patterns/specification_active_record"

RSpec.describe AllOverIt::Patterns::SpecificationActiveRecord::AlwaysTrueSpecificationActiveRecord do
  it "is always true (in-memory and SQL)" do
    spec = described_class.new
    expect(spec.satisfied_by?(Object.new)).to eq(true)
    expect(spec.to_arel(double(:table))).to eq(Arel.sql('1=1'))
    expect(spec.to_s).to eq("true")
  end
end

RSpec.describe AllOverIt::Patterns::SpecificationActiveRecord do
  describe ".always_true" do
    it "returns a new instance each time for always_true (AR)" do
      expect(described_class.always_true).not_to be(described_class.always_true)
    end

    it "returns the correct class for always_true (AR)" do
      expect(described_class.always_true.class.name).to match(/AlwaysTrueSpecificationActiveRecord/)
    end
  end
end
