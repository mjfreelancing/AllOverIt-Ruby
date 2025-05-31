# frozen_string_literal: true

require_relative "composite_specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      class OrNotSpecificationActiveRecord < CompositeSpecificationActiveRecord
        # Initializes a new OR NOT composite specification.
        #
        # @param left [SpecificationActiveRecord] The left-hand specification.
        # @param right [SpecificationActiveRecord] The right-hand specification to negate.
        def initialize(left, right)
          super()
          @left = left
          @right = right
        end

        # Checks if the candidate satisfies the left specification or does not satisfy the right specification.
        #
        # @param candidate [Object] The object to check.
        # @return [Boolean] True if the candidate satisfies the left or not the right specification.
        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) || !@right.satisfied_by?(candidate)
        end

        # Returns an Arel predicate representing the OR NOT logic for SQL queries.
        #
        # @param table [Arel::Table] The Arel table for building the predicate.
        # @return [Arel::Nodes::Node] The Arel predicate node.
        def to_arel(table)
          @left.to_arel(table).or(@right.to_arel(table).not)
        end

        # Returns a string representation of the OR NOT specification.
        #
        # @return [String] The string representation.
        def to_s
          "(#{@left} OR NOT #{@right})"
        end
      end
    end
  end
end
