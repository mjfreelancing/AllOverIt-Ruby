require_relative "../../../lib/alloverit/patterns/specification"
require_relative "../../../lib/alloverit/patterns/specification/composite_specification"

module Demo1
  module Specifications
    class IsLessThan < Alloverit::Patterns::Specification::CompositeSpecification
      def initialize(upper_bound)
        super()
        @upper_bound = upper_bound
      end

      def satisfied_by?(candidate)
        candidate.is_a?(Integer) && candidate < @upper_bound
      end
    end
  end
end
