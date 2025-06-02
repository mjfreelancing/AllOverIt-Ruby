# frozen_string_literal: true

require_relative "composite_specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      # A composite specification that is satisfied if the given specification is not satisfied.
      class NotSpecificationActiveRecord < CompositeSpecificationActiveRecord
        # Initializes a new NOT composite specification.
        #
        # @param spec [SpecificationActiveRecord] The specification to negate.
        def initialize(spec)
          super()
          @spec = spec
        end

        # Checks if the candidate does not satisfy the specification.
        #
        # @param candidate [Object] The object to check.
        # @return [Boolean] True if the candidate does not satisfy the specification.
        def satisfied_by?(candidate)
          !@spec.satisfied_by?(candidate)
        end

        # Returns an Arel predicate representing the NOT logic for SQL queries.
        #
        # @param table [Arel::Table] The Arel table for building the predicate.
        # @return [Arel::Nodes::Node] The Arel predicate node.
        def to_arel(table)
          @spec.to_arel(table).not
        end

        # Returns a string representation of the NOT specification.
        #
        # @return [String] The string representation.
        def to_s
          "(NOT #{@spec})"
        end
      end
    end
  end
end
