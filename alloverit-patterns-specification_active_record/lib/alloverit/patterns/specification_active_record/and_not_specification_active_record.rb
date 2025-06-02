# frozen_string_literal: true

require_relative "composite_specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      # A composite specification that is satisfied if the left specification is satisfied and the right is not.
      class AndNotSpecificationActiveRecord < CompositeSpecificationActiveRecord
        # Initializes a new AND NOT composite specification.
        #
        # @param left [SpecificationActiveRecord] The left-hand specification.
        # @param right [SpecificationActiveRecord] The right-hand specification to negate.
        def initialize(left, right)
          super()
          @left = left
          @right = right
        end

        # Checks if the candidate satisfies the left specification and does not satisfy the right specification.
        #
        # @param candidate [Object] The object to check.
        # @return [Boolean] True if the candidate satisfies the left and not the right specification.
        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) && !@right.satisfied_by?(candidate)
        end

        # Returns an Arel predicate representing the AND NOT logic for SQL queries.
        #
        # @param table [Arel::Table] The Arel table for building the predicate.
        # @return [Arel::Nodes::Node] The Arel predicate node.
        def to_arel(table)
          @left.to_arel(table).and(@right.to_arel(table).not)
        end

        # Returns a string representation of the AND NOT specification.
        #
        # @return [String] The string representation.
        def to_s
          "(#{@left} AND NOT #{@right})"
        end
      end
    end
  end
end
