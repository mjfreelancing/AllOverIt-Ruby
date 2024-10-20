# frozen_string_literal: true

require "alloverit/patterns/specification"

module Demo2
  module Specifications
    class IsMild < AllOverIt::Patterns::Specification::CompositeSpecification
      def satisfied_by?(chilli)
        chilli.scoville_range.upper < 10_000
      end
    end
  end
end
