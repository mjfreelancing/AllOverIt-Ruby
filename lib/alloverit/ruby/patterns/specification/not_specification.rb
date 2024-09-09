# frozen_string_literal: true

require_relative "composite_specification"

module Alloverit
  module Ruby
    module Patterns
      module Specification
        class NotSpecification < CompositeSpecification
          def initialize(candidate)
            super()
            @candidate = candidate
          end

          def satisfied_by?(candidate)
            !@candidate.satisfied_by?(candidate)
          end
        end
      end
    end
  end
end
