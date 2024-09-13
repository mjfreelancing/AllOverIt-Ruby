# frozen_string_literal: true

require_relative "specification"

module Alloverit
  module Patterns
    module Specification
      # Abstract base class for all concrete specifications.
      class CompositeSpecification
        include Specification

        # Class-level method for combining two specifications using a logical AND. Returns a new
        # `AndSpecification` object that represents the combined criteria.
        def self.and(other)
          other = other.new if other.is_a?(Class) # If a class is passed, instantiate it
          new.and(other)
        end

        # Class-level method for combining two specifications using a logical AND NOT. Returns a new
        # `AndNotSpecification` object that represents the combined criteria.
        def self.and_not(other)
          other = other.new if other.is_a?(Class) # If a class is passed, instantiate it
          new.and_not(other)
        end

        # Class-level method for combining two specifications using a logical OR. Returns a new
        # `OrSpecification` object that represents the combined criteria.
        def self.or(other)
          other = other.new if other.is_a?(Class) # If a class is passed, instantiate it
          new.or(other)
        end

        # Class-level method for combining two specifications using a logical OR NOT. Returns a new
        # `OrNotSpecification` object that represents the combined criteria.
        def self.or_not(other)
          other = other.new if other.is_a?(Class) # If a class is passed, instantiate it
          new.or_not(other)
        end

        # Class-level method for negating a specification. Returns a new `NotSpecification` object that represents
        # the negated criteria.
        def self.not
          new.not
        end

        protected

        def initialize; end
      end
    end
  end
end
