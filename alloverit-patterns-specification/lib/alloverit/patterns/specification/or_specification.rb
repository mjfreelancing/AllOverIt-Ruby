# frozen_string_literal: true

require_relative "composite_specification"

module AllOverIt
  module Patterns
    module Specification
      # Combines two specifications using logical OR. The resulting specification is satisfied if
      # either the left or right specification is satisfied by the candidate.
      class OrSpecification < CompositeSpecification
        # @param left [Specification] The left-hand specification.
        # @param right [Specification] The right-hand specification.
        def initialize(left, right)
          super()

          @left = left
          @right = right
        end

        # Determines if the candidate satisfies either the left or right specification.
        #
        # @param candidate [Object] The object to evaluate.
        # @return [Boolean] True if either specification is satisfied, false otherwise.
        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) || @right.satisfied_by?(candidate)
        end

        # Returns a string representation of the OR specification.
        #
        # @return [String] The string representation.
        def to_s
          "(#{@left} or #{@right})"
        end
      end
    end
  end
end
