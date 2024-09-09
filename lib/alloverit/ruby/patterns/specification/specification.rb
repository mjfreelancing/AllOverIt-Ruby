# frozen_string_literal: true

require_relative "and_specification"
require_relative "and_not_specification"
require_relative "or_specification"
require_relative "or_not_specification"
require_relative "not_specification"

module Alloverit
  module Ruby
    module Patterns
      module Specification
        def satisfied_by?(candidate)
          raise NotImplementedError, "You must implement #satisfied_by?"
        end

        def and(other)
          AndSpecification.new(self, other)
        end

        def and_not(other)
          AndNotSpecification.new(self, other)
        end

        def or(other)
          OrSpecification.new(self, other)
        end

        def or_not(other)
          OrNotSpecification.new(self, other)
        end

        def not
          NotSpecification.new(self)
        end
      end
    end
  end
end