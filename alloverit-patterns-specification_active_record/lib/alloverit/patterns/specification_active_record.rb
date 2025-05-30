# frozen_string_literal: true

require_relative "specification_active_record/and_specification_active_record"
require_relative "specification_active_record/and_not_specification_active_record"
require_relative "specification_active_record/or_specification_active_record"
require_relative "specification_active_record/or_not_specification_active_record"
require_relative "specification_active_record/not_specification_active_record"
require "alloverit/patterns/specification"
require "alloverit/utils"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      include AllOverIt::Patterns::Specification

      def satisfied_by?(candidate)
        raise NotImplementedError, "You must implement #satisfied_by?"
      end

      def to_scope(relation)
        raise NotImplementedError, "You must implement #to_scope"
      end

      def and(other)
        instance = Utils.as_instance(other)
        Utils.ensure_instance_includes(instance, SpecificationActiveRecord)
        AndSpecificationActiveRecord.new(self, instance)
      end

      def and_not(other)
        instance = Utils.as_instance(other)
        Utils.ensure_instance_includes(instance, SpecificationActiveRecord)
        AndNotSpecificationActiveRecord.new(self, instance)
      end

      def or(other)
        instance = Utils.as_instance(other)
        Utils.ensure_instance_includes(instance, SpecificationActiveRecord)
        OrSpecificationActiveRecord.new(self, instance)
      end

      def or_not(other)
        instance = Utils.as_instance(other)
        Utils.ensure_instance_includes(instance, SpecificationActiveRecord)
        OrNotSpecificationActiveRecord.new(self, instance)
      end

      def not
        NotSpecificationActiveRecord.new(self)
      end

      def to_s
        raise NotImplementedError, "You must implement #to_s"
      end
    end
  end
end
