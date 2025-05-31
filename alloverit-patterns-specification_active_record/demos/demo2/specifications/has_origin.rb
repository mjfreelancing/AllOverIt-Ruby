# frozen_string_literal: true

require "alloverit/patterns/specification_active_record"

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
        table[:origin].lower.eq(@origin)
      end

      def to_s
        "has origin #{@origin}"
      end
    end
  end
end
