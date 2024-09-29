# frozen_string_literal: true

require_relative "../../../../lib/alloverit/patterns/chain_of_responsibility/version"

module AllOverIt
  module Patterns
    module ChainOfResponsibility
      RSpec.describe VERSION do
        it "has a version number" do
          expect(AllOverIt::Patterns::ChainOfResponsibility::VERSION).not_to be nil
        end
      end
    end
  end
end
