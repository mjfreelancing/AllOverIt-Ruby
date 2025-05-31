# frozen_string_literal: true

require "spec_helper"
require "alloverit/patterns/specification_active_record"

RSpec.describe AllOverIt::Patterns::SpecificationActiveRecord::AlwaysFalseSpecificationActiveRecord do
  it "is always false (in-memory and SQL)" do
    spec = described_class.new
    expect(spec.satisfied_by?(Object.new)).to eq(false)
    expect(spec.to_arel(double(:table))).to eq(Arel.sql('1=0'))
    expect(spec.to_s).to eq("false")
  end
end

RSpec.describe AllOverIt::Patterns::SpecificationActiveRecord do
  describe ".always_false" do
    it "returns a new instance each time for always_false (AR)" do
      expect(described_class.always_false).not_to be(described_class.always_false)
    end
    
    it "returns the correct class for always_false (AR)" do
      expect(described_class.always_false.class.name).to match(/AlwaysFalseSpecificationActiveRecord/)
    end
  end
end
