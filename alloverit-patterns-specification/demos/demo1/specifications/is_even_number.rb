# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/specification"
require_relative "../../../lib/alloverit/patterns/specification/composite_specification"

module Demo1
  module Specifications
    class IsEvenNumber < AllOverIt::Patterns::Specification::CompositeSpecification
      def satisfied_by?(candidate)
        candidate.is_a?(Integer) && candidate.even?
      end
    end
  end
end
