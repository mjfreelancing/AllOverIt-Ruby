# frozen_string_literal: true

require "alloverit/patterns/specification_active_record"

module Demo2
  module Specifications
    class IsMild < AllOverIt::Patterns::SpecificationActiveRecord::CompositeSpecificationActiveRecord
      def satisfied_by?(chilli)
        chilli.scoville_upper < 10_000
      end

      def to_arel(table)
        table[:scoville_upper].lt(10_000)
      end

      def to_s
        "is mild (< 10,000 SHU)"
      end
    end
  end
end
