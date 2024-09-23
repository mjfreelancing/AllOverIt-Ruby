# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/specification"
require_relative "../../../lib/alloverit/patterns/specification/composite_specification"

module Demo2
  module Specifications
    class HasColor < AllOverIt::Patterns::Specification::CompositeSpecification
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
