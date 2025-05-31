require "spec_helper"

RSpec.describe AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord do
  class DummySpec < described_class
    def satisfied_by?(candidate); true; end
    def to_arel(table); table[:id].eq(1); end
    def to_s; "dummy"; end
  end

  let(:spec) { DummySpec.new }

  describe ".and" do
    it "returns an AndSpecificationActiveRecord" do
      result = DummySpec.and(DummySpec.new)
      expect(result).to be_a(AllOverIt::Patterns::SpecificationActiveRecord::AndSpecificationActiveRecord)
    end
  end

  describe ".and_not" do
    it "returns an AndNotSpecificationActiveRecord" do
      result = DummySpec.and_not(DummySpec.new)
      expect(result).to be_a(AllOverIt::Patterns::SpecificationActiveRecord::AndNotSpecificationActiveRecord)
    end
  end

  describe ".or" do
    it "returns an OrSpecificationActiveRecord" do
      result = DummySpec.or(DummySpec.new)
      expect(result).to be_a(AllOverIt::Patterns::SpecificationActiveRecord::OrSpecificationActiveRecord)
    end
  end

  describe ".or_not" do
    it "returns an OrNotSpecificationActiveRecord" do
      result = DummySpec.or_not(DummySpec.new)
      expect(result).to be_a(AllOverIt::Patterns::SpecificationActiveRecord::OrNotSpecificationActiveRecord)
    end
  end

  describe ".not" do
    it "returns a NotSpecificationActiveRecord" do
      result = DummySpec.not
      expect(result).to be_a(AllOverIt::Patterns::SpecificationActiveRecord::NotSpecificationActiveRecord)
    end
  end

  describe "#to_s" do
    it "returns the expected string representation for AND" do
      spec = DummySpec.new.and(DummySpec.new)
      expect(spec.to_s).to eq("(dummy AND dummy)")
    end
    
    it "returns the expected string representation for AND NOT" do
      spec = DummySpec.new.and_not(DummySpec.new)
      expect(spec.to_s).to eq("(dummy AND NOT dummy)")
    end

    it "returns the expected string representation for OR" do
      spec = DummySpec.new.or(DummySpec.new)
      expect(spec.to_s).to eq("(dummy OR dummy)")
    end

    it "returns the expected string representation for OR NOT" do
      spec = DummySpec.new.or_not(DummySpec.new)
      expect(spec.to_s).to eq("(dummy OR NOT dummy)")
    end

    it "returns the expected string representation for NOT" do
      spec = DummySpec.new.not
      expect(spec.to_s).to eq("(NOT dummy)")
    end
  end
end
