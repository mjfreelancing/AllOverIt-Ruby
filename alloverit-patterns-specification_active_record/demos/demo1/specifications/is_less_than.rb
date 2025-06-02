# frozen_string_literal: true

require "alloverit/patterns/specification_active_record"
require "alloverit/patterns/specification_active_record/arel_helpers"

module Demo1
  module Specifications
    class IsLessThan < AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord
      def initialize(threshold)
        @threshold = threshold
      end

      def satisfied_by?(candidate)
        candidate.value < @threshold
      end

      def to_arel(table)
        ArelHelpers.less_than(table[:value], @threshold)
      end

      def to_s
        "is less than #{@threshold}"
      end
    end
  end
end
