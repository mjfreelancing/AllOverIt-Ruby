# frozen_string_literal: true

module AllOverIt
  module Patterns
    module Specification
      # Defines a specification that is always satisfied.
      #
      # This is useful as a starting point for dynamically building specifications
      # where you want to match everything by default, and then add conditions with `and`.
      #
      # @example
      #   spec = AllOverIt::Patterns::Specification.always_true
      #   spec = spec.and(SomeOtherSpecification.new)
      #
      # @see AllOverIt::Patterns::Specification.always_true
      class AlwaysTrueSpecification < CompositeSpecification
        # Always returns true, regardless of the candidate.
        #
        # @param _candidate [Object] The object to test (ignored).
        # @return [Boolean] Always true.
        def satisfied_by?(_candidate) = true

        # Returns a string representation of the specification.
        #
        # @return [String] The string "true".
        def to_s = "true"
      end
    end
  end
end
