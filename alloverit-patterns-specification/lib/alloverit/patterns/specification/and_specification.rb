# frozen_string_literal: true

require_relative "composite_specification"

module AllOverIt
  module Patterns
    module Specification
      # Combines two specifications using logical AND. The resulting specification is satisfied only if
      # both the left and right specifications are satisfied by the candidate.
      class AndSpecification < CompositeSpecification
        # @param left [Specification] The left-hand specification.
        # @param right [Specification] The right-hand specification.
        def initialize(left, right)
          super()

          @left = left
          @right = right
        end

        # Determines if the candidate satisfies both the left and right specifications.
        #
        # @param candidate [Object] The object to evaluate.
        # @return [Boolean] True if both specifications are satisfied, false otherwise.
        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) && @right.satisfied_by?(candidate)
        end

        # Returns a string representation of the AND specification.
        #
        # @return [String] The string representation.
        def to_s
          "(#{@left} and #{@right})"
        end
      end
    end
  end
end
