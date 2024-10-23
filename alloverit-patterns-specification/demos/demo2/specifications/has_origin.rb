# frozen_string_literal: true

require "alloverit/patterns/specification"

module Demo2
  module Specifications
    class HasOrigin < AllOverIt::Patterns::Specification::CompositeSpecification
      def initialize(origin)
        super()

        @origin = origin.downcase
      end

      def satisfied_by?(chilli)
        chilli.origin.downcase == @origin
      end

      def to_s
        "origin is #{@origin}"
      end
    end
  end
end
