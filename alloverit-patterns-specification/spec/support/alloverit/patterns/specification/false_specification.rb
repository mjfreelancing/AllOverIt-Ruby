# frozen_string_literal: true

require_relative "../../../../../lib/alloverit/patterns/specification/composite_specification"

module Support
  module AllOverIt
    module Patterns
      module Specification
        class FalseSpecification < ::AllOverIt::Patterns::Specification::CompositeSpecification
          def satisfied_by?(_)
            false
          end
        end
      end
    end
  end
end
