# frozen_string_literal: true

require_relative "../utils"
require_relative "specification/and_specification"
require_relative "specification/and_not_specification"
require_relative "specification/or_specification"
require_relative "specification/or_not_specification"
require_relative "specification/not_specification"

module AllOverIt
  module Patterns
    # The Specification module defines a set of methods for creating and combining specifications. Each method
    # returns a new specification object, allowing for composition and chaining of different specifications.
    #
    # Implementations of this module must define the *satisfied_by?* method to specify the actual criteria.
    module Specification
      # This method must be implemented by any class including this module. It should return a boolean indicating
      # whether the given `candidate` satisfies the specification.
      def satisfied_by?(candidate)
        raise NotImplementedError, "You must implement #satisfied_by?"
      end

      # Combines the current specification with another specification using a logical AND. Returns a new
      # AndSpecification object that represents the combined criteria.
      def and(other)
        instance = Utils.ensure_instance(other)
        AndSpecification.new(self, instance)
      end

      # Combines the current specification with another specification using a logical AND NOT. Returns a new
      # AndNotSpecification object that represents the combined criteria.
      def and_not(other)
        instance = Utils.ensure_instance(other)
        AndNotSpecification.new(self, instance)
      end

      # Combines the current specification with another specification using a logical OR. Returns a new
      # OrSpecification object that represents the combined criteria.
      def or(other)
        instance = Utils.ensure_instance(other)
        OrSpecification.new(self, instance)
      end

      # Combines the current specification with another specification using a logical OR NOT. Returns a new
      # OrNotSpecification object that represents the combined criteria.
      def or_not(other)
        instance = Utils.ensure_instance(other)
        OrNotSpecification.new(self, instance)
      end

      # Negates the current specification. Returns a new NotSpecification object that represents the negated criteria.
      def not
        NotSpecification.new(self)
      end
    end
  end
end
