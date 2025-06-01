# frozen_string_literal: true

require_relative "composite_specification"

module AllOverIt
  module Patterns
    module Specification
      # Combines two specifications using logical AND NOT. The resulting specification is satisfied only if
      # the left specification is satisfied and the right specification is not satisfied by the candidate.
      class AndNotSpecification < CompositeSpecification
        # @param left [Specification] The left-hand specification.
        # @param right [Specification] The right-hand specification to negate.
        def initialize(left, right)
          super()

          @left = left
          @right = right
        end

        # Determines if the candidate satisfies the left specification and does not satisfy the right specification.
        #
        # @param candidate [Object] The object to evaluate.
        # @return [Boolean] True if left is satisfied and right is not, false otherwise.
        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) && !@right.satisfied_by?(candidate)
        end

        # Returns a string representation of the AND NOT specification.
        #
        # @return [String] The string representation.
        def to_s
          "(#{@left} and not (#{@right}))"
        end
      end
    end
  end
end
