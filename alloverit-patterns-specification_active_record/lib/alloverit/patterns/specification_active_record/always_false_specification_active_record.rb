# frozen_string_literal: true

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      # A specification that is never satisfied (always returns false).
      #
      # This can be used as a default or placeholder specification that matches no candidates.
      class AlwaysFalseSpecificationActiveRecord < CompositeSpecificationActiveRecord
        # Checks if the specification is satisfied by the given candidate.
        #
        # @param _candidate [Object] The object to check (unused).
        # @return [Boolean] Always returns false.
        def satisfied_by?(_candidate) = false

        # Returns an Arel predicate that always evaluates to false (1=0).
        #
        # @param _table [Arel::Table] The Arel table (unused).
        # @return [Arel::Nodes::SqlLiteral] The Arel node representing 1=0.
        def to_arel(_table) = Arel.sql("1=0")

        # Returns a string representation of the specification.
        #
        # @return [String] The string "false".
        def to_s = "false"
      end
    end
  end
end
