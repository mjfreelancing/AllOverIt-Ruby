# frozen_string_literal: true

require_relative "../../utils"
require_relative "../specification"

module AllOverIt
  module Patterns
    module Specification
      # Abstract base class for all concrete specifications.
      class CompositeSpecification
        include Specification

        # Class-level method for combining two specifications using a logical AND. Returns a new
        # AndSpecification object that represents the combined criteria.
        def self.and(other)
          instance = instantiate_if_class(other)
          new.and(instance)
        end

        # Class-level method for combining two specifications using a logical AND NOT. Returns a new
        # AndNotSpecification object that represents the combined criteria.
        def self.and_not(other)
          instance = instantiate_if_class(other)
          new.and_not(instance)
        end

        # Class-level method for combining two specifications using a logical OR. Returns a new
        # OrSpecification object that represents the combined criteria.
        def self.or(other)
          instance = instantiate_if_class(other)
          new.or(instance)
        end

        # Class-level method for combining two specifications using a logical OR NOT. Returns a new
        # OrNotSpecification object that represents the combined criteria.
        def self.or_not(other)
          instance = instantiate_if_class(other)
          new.or_not(instance)
        end

        # Class-level method for negating a specification. Returns a new NotSpecification object that represents
        # the negated criteria.
        def self.not
          new.not
        end

        class << self
          private

          def instantiate_if_class(other)
            instance = Utils.ensure_instance(other)

            unless instance.is_a?(CompositeSpecification)
              raise ArgumentError, "Expected an instance of #{CompositeSpecification.name}, got #{instance.class}"
            end

            instance
          end
        end
      end
    end
  end
end
