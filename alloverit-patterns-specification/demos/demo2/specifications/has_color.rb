require_relative "../../../lib/alloverit/patterns/specification/specification"
require_relative "../../../lib/alloverit/patterns/specification/composite_specification"

module Demo2
  module Specifications
    class HasColor < Alloverit::Patterns::Specification::CompositeSpecification
      def initialize(color)
        super()

        @color = color.downcase
      end
      def satisfied_by?(chilli)
        chilli.colors.any? { |color| color.downcase == @color }
      end
    end
  end
end
