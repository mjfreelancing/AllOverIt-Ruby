# frozen_string_literal: true

require_relative "composite_specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      # A composite specification that is satisfied if either the left or right specification is satisfied.
      class OrSpecificationActiveRecord < CompositeSpecificationActiveRecord
        # Initializes a new OR composite specification.
        #
        # @param left [SpecificationActiveRecord] The left-hand specification.
        # @param right [SpecificationActiveRecord] The right-hand specification.
        def initialize(left, right)
          super()
          @left = left
          @right = right
        end

        # Checks if the candidate satisfies either the left or right specification.
        #
        # @param candidate [Object] The object to check.
        # @return [Boolean] True if the candidate satisfies either specification.
        def satisfied_by?(candidate)
          @left.satisfied_by?(candidate) || @right.satisfied_by?(candidate)
        end

        # Returns an Arel predicate representing the OR logic for SQL queries.
        #
        # @param table [Arel::Table] The Arel table for building the predicate.
        # @return [Arel::Nodes::Node] The Arel predicate node.
        def to_arel(table)
          @left.to_arel(table).or(@right.to_arel(table))
        end

        # Returns a string representation of the OR specification.
        #
        # @return [String] The string representation.
        def to_s
          "(#{@left} OR #{@right})"
        end
      end
    end
  end
end
