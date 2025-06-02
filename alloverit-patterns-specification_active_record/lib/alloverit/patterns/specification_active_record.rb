# frozen_string_literal: true

require_relative "specification_active_record/and_specification_active_record"
require_relative "specification_active_record/and_not_specification_active_record"
require_relative "specification_active_record/or_specification_active_record"
require_relative "specification_active_record/or_not_specification_active_record"
require_relative "specification_active_record/not_specification_active_record"
require_relative "specification_active_record/always_true_specification_active_record"
require_relative "specification_active_record/always_false_specification_active_record"
require "alloverit/patterns/specification"
require "alloverit/utils"

module AllOverIt
  module Patterns
    # Provides ActiveRecord specification pattern support for AllOverIt.
    module SpecificationActiveRecord
      include AllOverIt::Patterns::Specification

      # Checks if the specification is satisfied by the given candidate (in-memory evaluation).
      #
      # @param candidate [Object] The object to check against the specification.
      # @return [Boolean] True if the candidate satisfies the specification, otherwise false.
      # @raise [NotImplementedError] If not implemented in a subclass.
      def satisfied_by?(candidate)
        raise NotImplementedError, "You must implement #satisfied_by?"
      end

      # Returns an Arel predicate representing this specification for use in SQL queries.
      #
      # @param table [Arel::Table] The Arel table for building the predicate.
      # @return [Arel::Nodes::Node] The Arel predicate node.
      # @raise [NotImplementedError] If not implemented in a subclass.
      def to_arel(table)
        raise NotImplementedError, "You must implement #to_arel"
      end

      # Applies the specification as a WHERE clause to the given ActiveRecord relation.
      #
      # @param relation [ActiveRecord::Relation] The relation to apply the specification to.
      # @return [ActiveRecord::Relation] The relation with the specification applied as a WHERE clause.
      def to_scope(relation)
        table = relation.klass.arel_table
        relation.where(to_arel(table))
      end

      # Combines this specification with another using logical AND.
      #
      # @param other [SpecificationActiveRecord] The other specification to combine with.
      # @return [AndSpecificationActiveRecord] A new AND composite specification.
      def and(other)
        instance = Utils.as_instance(other)
        Utils.ensure_instance_includes(instance, SpecificationActiveRecord)
        AndSpecificationActiveRecord.new(self, instance)
      end

      # Combines this specification with the negation of another using logical AND NOT.
      #
      # @param other [SpecificationActiveRecord] The other specification to negate and combine with.
      # @return [AndNotSpecificationActiveRecord] A new AND NOT composite specification.
      def and_not(other)
        instance = Utils.as_instance(other)
        Utils.ensure_instance_includes(instance, SpecificationActiveRecord)
        AndNotSpecificationActiveRecord.new(self, instance)
      end

      # Combines this specification with another using logical OR.
      #
      # @param other [SpecificationActiveRecord] The other specification to combine with.
      # @return [OrSpecificationActiveRecord] A new OR composite specification.
      def or(other)
        instance = Utils.as_instance(other)
        Utils.ensure_instance_includes(instance, SpecificationActiveRecord)
        OrSpecificationActiveRecord.new(self, instance)
      end

      # Combines this specification with the negation of another using logical OR NOT.
      #
      # @param other [SpecificationActiveRecord] The other specification to negate and combine with.
      # @return [OrNotSpecificationActiveRecord] A new OR NOT composite specification.
      def or_not(other)
        instance = Utils.as_instance(other)
        Utils.ensure_instance_includes(instance, SpecificationActiveRecord)
        OrNotSpecificationActiveRecord.new(self, instance)
      end

      # Returns the negation of this specification.
      #
      # @return [NotSpecificationActiveRecord] A new negated specification.
      def not
        NotSpecificationActiveRecord.new(self)
      end

      # Returns a string representation of the specification.
      #
      # @return [String] The string representation.
      # @raise [NotImplementedError] If not implemented in a subclass.
      def to_s
        raise NotImplementedError, "You must implement #to_s"
      end

      # Returns a new instance of a specification that is always true.
      def self.always_true
        AlwaysTrueSpecificationActiveRecord.new
      end

      # Returns a new instance of a specification that is always false.
      def self.always_false
        AlwaysFalseSpecificationActiveRecord.new
      end
    end
  end
end
