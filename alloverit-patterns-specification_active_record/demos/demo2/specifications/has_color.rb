# frozen_string_literal: true

require "alloverit/patterns/specification_active_record"
require "alloverit/patterns/specification_active_record/arel_helpers"

module Demo2
  module Specifications
    class HasColor < AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord
      def initialize(color)
        @color = color.downcase
      end

      def satisfied_by?(chilli)
        chilli.color_list.map(&:downcase).include?(@color)
      end

      def to_arel(table)
        ArelHelpers.equals_insensitive(table[:colors], @color)
      end

      def to_s
        "has color #{@color}"
      end
    end
  end
end
