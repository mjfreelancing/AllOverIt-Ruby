# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/specification/version"

RSpec.describe Alloverit::Patterns::Specification do
  it "has a version number" do
    expect(Alloverit::Patterns::Specification::VERSION).not_to be nil
  end

  # it "does something useful" do
  #   expect(false).to eq(true)
  # end
end
