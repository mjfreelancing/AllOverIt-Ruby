# frozen_string_literal: true

require "alloverit/patterns/specification_active_record"
require "alloverit/patterns/specification_active_record/arel_helpers"

module Demo2
  module Specifications
    class HasOrigin < AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord
      def initialize(origin)
        @origin = origin.downcase
      end

      def satisfied_by?(chilli)
        chilli.origin.downcase == @origin
      end

      def to_arel(table)
        ArelHelpers.equals_insensitive(table[:origin], @origin)
      end

      def to_s
        "has origin #{@origin}"
      end
    end
  end
end
