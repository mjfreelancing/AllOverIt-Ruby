# frozen_string_literal: true

require_relative "composite_specification"

module AllOverIt
  module Patterns
    module Specification
      class NotSpecification < CompositeSpecification
        def initialize(specification)
          super()

          @specification = specification
        end

        def satisfied_by?(candidate)
          !@specification.satisfied_by?(candidate)
        end

        def to_s
          "not (#{@specification})"
        end
      end
    end
  end
end
