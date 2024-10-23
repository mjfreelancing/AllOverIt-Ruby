# frozen_string_literal: true

require "alloverit/patterns/specification"

module Demo1
  module Specifications
    class IsLessThan < AllOverIt::Patterns::Specification::CompositeSpecification
      def initialize(upper_bound)
        super()
        @upper_bound = upper_bound
      end

      def satisfied_by?(candidate)
        candidate.is_a?(Integer) && candidate < @upper_bound
      end

      def to_s
        "candidate < #{@upper_bound}"
      end
    end
  end
end
