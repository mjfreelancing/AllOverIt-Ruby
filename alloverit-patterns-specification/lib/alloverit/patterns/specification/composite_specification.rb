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
          instance = ensure_instance(other)
          new.and(instance)
        end

        # Class-level method for combining two specifications using a logical AND NOT. Returns a new
        # AndNotSpecification object that represents the combined criteria.
        def self.and_not(other)
          instance = ensure_instance(other)
          new.and_not(instance)
        end

        # Class-level method for combining two specifications using a logical OR. Returns a new
        # OrSpecification object that represents the combined criteria.
        def self.or(other)
          instance = ensure_instance(other)
          new.or(instance)
        end

        # Class-level method for combining two specifications using a logical OR NOT. Returns a new
        # OrNotSpecification object that represents the combined criteria.
        def self.or_not(other)
          instance = ensure_instance(other)
          new.or_not(instance)
        end

        # Class-level method for negating a specification. Returns a new NotSpecification object that represents
        # the negated criteria.
        def self.not
          new.not
        end

        class << self
          private

          def ensure_instance(other)
            instance = Utils.as_instance(other)

            Utils.ensure_instance_includes(instance, Specification)
          end
        end
      end
    end
  end
end
