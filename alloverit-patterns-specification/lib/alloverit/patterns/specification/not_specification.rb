# frozen_string_literal: true

require_relative "composite_specification"

module AllOverIt
  module Patterns
    module Specification
      class NotSpecification < CompositeSpecification
        # Negates a specification. The resulting specification is satisfied only if the original specification is not satisfied by the candidate.
        #
        # @param specification [Specification] The specification to negate.
        def initialize(specification)
          super()

          @specification = specification
        end

        # Determines if the candidate does not satisfy the original specification.
        #
        # @param candidate [Object] The object to evaluate.
        # @return [Boolean] True if the specification is not satisfied, false otherwise.
        def satisfied_by?(candidate)
          !@specification.satisfied_by?(candidate)
        end

        # Returns a string representation of the NOT specification.
        #
        # @return [String] The string representation.
        def to_s
          "not (#{@specification})"
        end
      end
    end
  end
end
