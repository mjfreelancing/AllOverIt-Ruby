# frozen_string_literal: true

require_relative "../../../../lib/alloverit/patterns/specification_active_record/version"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      RSpec.describe VERSION do
        it "has a version number" do
          expect(AllOverIt::Patterns::SpecificationActiveRecord::VERSION).not_to be nil
        end
      end
    end
  end
end
