# frozen_string_literal: true

require_relative "../../../lib/alloverit/utils/version"

module AllOverIt
  module Utils
    RSpec.describe VERSION do
      it "has a version number" do
        expect(AllOverIt::Utils::VERSION).not_to be nil
      end
    end
  end
end
