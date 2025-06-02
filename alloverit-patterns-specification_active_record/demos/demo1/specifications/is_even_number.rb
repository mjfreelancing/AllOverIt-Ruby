# frozen_string_literal: true

require "alloverit/patterns/specification_active_record"
require "alloverit/patterns/specification_active_record/arel_helpers"

module Demo1
  module Specifications
    class IsEvenNumber < AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord
      def satisfied_by?(candidate)
        candidate.value.even?
      end

      def to_arel(table)
        ArelHelpers.modulo(table[:value], 2).eq(0)
      end

      def to_s
        "is even"
      end
    end
  end
end
