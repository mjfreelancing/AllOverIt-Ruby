require_relative "../../../lib/alloverit/patterns/specification/specification"
require_relative "../../../lib/alloverit/patterns/specification/composite_specification"

module Demo2
  module Specifications
    class HasOrigin < Alloverit::Patterns::Specification::CompositeSpecification
      def initialize(origin)
        super()

        @origin = origin.downcase
      end
      def satisfied_by?(chilli)
        chilli.origin.downcase == @origin
      end
    end
  end
end
