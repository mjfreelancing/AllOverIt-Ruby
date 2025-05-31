# frozen_string_literal: true

module AllOverIt
  module Patterns
    module Specification
      # A specification that is never satisfied.
      #
      # This is useful as a starting point for dynamically building specifications
      # where you want to match nothing by default, and then add conditions with `or`.
      #
      # @example
      #   spec = AllOverIt::Patterns::Specification.always_false
      #   spec = spec.or(SomeOtherSpecification.new)
      #
      # @see AllOverIt::Patterns::Specification.always_false
      class AlwaysFalseSpecification < CompositeSpecification
        # Always returns false, regardless of the candidate.
        #
        # @param _candidate [Object] The object to test (ignored).
        # @return [Boolean] Always false.
        def satisfied_by?(_candidate) = false

        # Returns a string representation of the specification.
        #
        # @return [String] The string "false".
        def to_s = "false"
      end
    end
  end
end
