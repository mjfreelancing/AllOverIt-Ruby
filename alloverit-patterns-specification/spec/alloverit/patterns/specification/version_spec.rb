# frozen_string_literal: true

require_relative "../../../../lib/alloverit/patterns/specification/version"

module AllOverIt::Patterns::Specification
  RSpec.describe VERSION do
    it "has a version number" do
      expect(AllOverIt::Patterns::Specification::VERSION).not_to be nil
    end
  end
end
