# frozen_string_literal: true

require_relative "../../../../lib/alloverit/patterns/specification/version"

module Alloverit
  module Patterns
    module Specification
      module VersionFixture
        RSpec.describe Specification do
          it "has a version number" do
            expect(Alloverit::Patterns::Specification::VERSION).not_to be nil
          end
        end
      end
    end
  end
end
