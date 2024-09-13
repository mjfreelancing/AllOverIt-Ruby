# frozen_string_literal: true

require_relative "and_specification"
require_relative "and_not_specification"
require_relative "or_specification"
require_relative "or_not_specification"
require_relative "not_specification"

module Alloverit
  module Patterns
    # The `Specification` module defines a set of methods for creating and combining specifications. Each method
    # returns a new specification object, allowing for composition and chaining of different specifications.
    #
    # Implementations of this module must define the `satisfied_by?` method to specify the actual criteria.
    module Specification
      # This method must be implemented by any class including this module. It should return a boolean indicating
      # whether the given `candidate` satisfies the specification.
      def satisfied_by?(candidate)
        raise NotImplementedError, "You must implement #satisfied_by?"
      end

      # Combines the current specification with another specification using a logical AND. Returns a new
      # `AndSpecification` object that represents the combined criteria.
      def and(other)
        other = other.new if other.is_a?(Class) # If a class is passed, instantiate it
        AndSpecification.new(self, other)
      end

      # Combines the current specification with another specification using a logical AND NOT. Returns a new
      # `AndNotSpecification` object that represents the combined criteria.
      def and_not(other)
        other = other.new if other.is_a?(Class) # If a class is passed, instantiate it
        AndNotSpecification.new(self, other)
      end

      # Combines the current specification with another specification using a logical OR. Returns a new
      # `OrSpecification` object that represents the combined criteria.
      def or(other)
        other = other.new if other.is_a?(Class) # If a class is passed, instantiate it
        OrSpecification.new(self, other)
      end

      # Combines the current specification with another specification using a logical OR NOT. Returns a new
      # `OrNotSpecification` object that represents the combined criteria.
      def or_not(other)
        other = other.new if other.is_a?(Class) # If a class is passed, instantiate it
        OrNotSpecification.new(self, other)
      end

      # Negates the current specification. Returns a new `NotSpecification` object that represents the negated criteria.
      def not
        NotSpecification.new(self)
      end
    end
  end
end
