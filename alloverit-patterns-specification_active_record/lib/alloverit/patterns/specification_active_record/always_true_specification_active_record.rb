# frozen_string_literal: true

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      # A specification that is always satisfied (always returns true).
      #
      # This can be used as a default or placeholder specification that matches all candidates.
      class AlwaysTrueSpecificationActiveRecord < CompositeSpecificationActiveRecord
        # Checks if the specification is satisfied by the given candidate.
        #
        # @param _candidate [Object] The object to check (unused).
        # @return [Boolean] Always returns true.
        def satisfied_by?(_candidate) = true

        # Returns an Arel predicate that always evaluates to true (1=1).
        #
        # @param _table [Arel::Table] The Arel table (unused).
        # @return [Arel::Nodes::SqlLiteral] The Arel node representing 1=1.
        def to_arel(_table) = Arel.sql("1=1")

        # Returns a string representation of the specification.
        #
        # @return [String] The string "true".
        def to_s = "true"
      end
    end
  end
end
