# frozen_string_literal: true

require_relative "composite_specification"

module AllOverIt
  module Patterns
    module Specification
      class OrNotSpecification < CompositeSpecification
        # Combines two specifications using logical OR NOT. The resulting specification is satisfied if
        # the left specification is satisfied or the right specification is not satisfied by the candidate.
        #
        # @param left [Specification] The left-hand specification.
        # @param right [Specification] The right-hand specification to negate.
        def initialize(left, right)
          super()

          @left = left
          @right = right
        end

        # Determines if the candidate satisfies the left specification or does not satisfy the right specification.
        #
        # @param candidate [Object] The object to evaluate.
        # @return [Boolean] True if left is satisfied or right is not, false otherwise.
        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) || !@right.satisfied_by?(candidate)
        end

        # Returns a string representation of the OR NOT specification.
        #
        # @return [String] The string representation.
        def to_s
          "(#{@left} or not (#{@right}))"
        end
      end
    end
  end
end
