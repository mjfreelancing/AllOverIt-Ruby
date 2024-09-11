# frozen_string_literal: true

require_relative "specification"

module Alloverit
  module Patterns
    module Specification
      # Abstract base class for composite specifications
      class CompositeSpecification
        include Specification

        def initialize
          return unless instance_of?(CompositeSpecification)

          raise SpecificationError, "Cannot instantiate #{self.class.name}"
        end
      end
    end
  end
end
