# frozen_string_literal: true

require_relative "composite_specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      # A composite specification that is satisfied only if both left and right specifications are satisfied.
      class AndSpecificationActiveRecord < CompositeSpecificationActiveRecord
        # Initializes a new AND composite specification.
        #
        # @param left [SpecificationActiveRecord] The left-hand specification.
        # @param right [SpecificationActiveRecord] The right-hand specification.
        def initialize(left, right)
          super()
          @left = left
          @right = right
        end

        # Checks if the candidate satisfies both left and right specifications.
        #
        # @param candidate [Object] The object to check.
        # @return [Boolean] True if the candidate satisfies both specifications.
        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) && @right.satisfied_by?(candidate)
        end

        # Returns an Arel predicate representing the AND logic for SQL queries.
        #
        # @param table [Arel::Table] The Arel table for building the predicate.
        # @return [Arel::Nodes::Node] The Arel predicate node.
        def to_arel(table)
          @left.to_arel(table).and(@right.to_arel(table))
        end

        # Returns a string representation of the AND specification.
        #
        # @return [String] The string representation.
        def to_s
          "(#{@left} AND #{@right})"
        end
      end
    end
  end
end
