require_relative "../../../lib/alloverit/patterns/specification"
require_relative "../../../lib/alloverit/patterns/specification/composite_specification"

module Demo1
  module Specifications
    class IsEvenNumber < Alloverit::Patterns::Specification::CompositeSpecification
      def satisfied_by?(candidate)
        candidate.is_a?(Integer) && candidate.even?
      end
    end
  end
end
