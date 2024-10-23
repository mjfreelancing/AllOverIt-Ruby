# frozen_string_literal: true

require "alloverit/patterns/specification"

module Demo1
  module Specifications
    class IsEvenNumber < AllOverIt::Patterns::Specification::CompositeSpecification
      def satisfied_by?(candidate)
        candidate.is_a?(Integer) && candidate.even?
      end

      def to_s
        "candidate.even?"
      end
    end
  end
end
