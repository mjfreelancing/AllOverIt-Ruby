# frozen_string_literal: true

require_relative "../../../lib/alloverit/utils/version"

RSpec.describe AllOverIt::Utils::VERSION do
  it "has a version number" do
    expect(AllOverIt::Utils::VERSION).not_to be nil
  end
end
