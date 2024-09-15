# frozen_string_literal: true

require_relative "../../../../../lib/alloverit/patterns/specification"

module Support
  module Alloverit
    module Patterns
      module Specification
        class BadSpecification
          # should implement CompositeSpecification
          include Specification
        end
      end
    end
  end
end
