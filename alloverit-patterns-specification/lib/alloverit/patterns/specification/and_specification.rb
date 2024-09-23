# frozen_string_literal: true

require_relative "composite_specification"

module AllOverIt
  module Patterns
    module Specification
      class AndSpecification < CompositeSpecification
        def initialize(left, right)
          super()

          @left = left
          @right = right
        end

        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) && @right.satisfied_by?(candidate)
        end
      end
    end
  end
end
