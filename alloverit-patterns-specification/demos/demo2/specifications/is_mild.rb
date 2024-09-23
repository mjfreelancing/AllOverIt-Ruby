# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/specification"
require_relative "../../../lib/alloverit/patterns/specification/composite_specification"

module Demo2
  module Specifications
    class IsMild < AllOverIt::Patterns::Specification::CompositeSpecification
      def satisfied_by?(chilli)
        chilli.scoville_range.upper < 10_000
      end
    end
  end
end
