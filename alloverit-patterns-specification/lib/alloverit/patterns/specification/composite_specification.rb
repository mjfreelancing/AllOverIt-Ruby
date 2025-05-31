# frozen_string_literal: true

require "alloverit/utils"

require_relative "../specification"

module AllOverIt
  module Patterns
    module Specification
      # Abstract base class for all composite specifications. Provides class-level combinators for
      # AND, AND NOT, OR, OR NOT, and NOT, allowing for flexible composition of specifications.
      #
      # Subclasses must implement the #satisfied_by? and #to_s methods.
      class CompositeSpecification
        include Specification

        # Combines two specifications using logical AND. Returns a new AndSpecification object.
        #
        # @param other [Specification] The other specification to combine with.
        # @return [AndSpecification] The combined specification.
        def self.and(other)
          instance = ensure_instance(other)
          new.and(instance)
        end

        # Combines two specifications using logical AND NOT. Returns a new AndNotSpecification object.
        #
        # @param other [Specification] The other specification to negate and combine with.
        # @return [AndNotSpecification] The combined specification.
        def self.and_not(other)
          instance = ensure_instance(other)
          new.and_not(instance)
        end

        # Combines two specifications using logical OR. Returns a new OrSpecification object.
        #
        # @param other [Specification] The other specification to combine with.
        # @return [OrSpecification] The combined specification.
        def self.or(other)
          instance = ensure_instance(other)
          new.or(instance)
        end

        # Combines two specifications using logical OR NOT. Returns a new OrNotSpecification object.
        #
        # @param other [Specification] The other specification to negate and combine with.
        # @return [OrNotSpecification] The combined specification.
        def self.or_not(other)
          instance = ensure_instance(other)
          new.or_not(instance)
        end

        # Negates a specification. Returns a new NotSpecification object.
        #
        # @return [NotSpecification] The negated specification.
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
