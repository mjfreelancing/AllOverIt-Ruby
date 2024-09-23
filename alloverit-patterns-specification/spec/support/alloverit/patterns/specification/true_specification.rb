# frozen_string_literal: true

require_relative "../../../../../lib/alloverit/patterns/specification/composite_specification"

module Support
  module AllOverIt
    module Patterns
      module Specification
        class TrueSpecification < ::AllOverIt::Patterns::Specification::CompositeSpecification
          def satisfied_by?(_)
            true
          end
        end
      end
    end
  end
end
