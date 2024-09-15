# frozen_string_literal: true

require_relative "../../../../../lib/alloverit/patterns/specification/composite_specification"

module Support
  module Alloverit
    module Patterns
      module Specification
        class TrueSpecification < ::Alloverit::Patterns::Specification::CompositeSpecification
          def satisfied_by?(_)
            true
          end
        end
      end
    end
  end
end
