# frozen_string_literal: true

require_relative "../specification_active_record"

module AllOverIt
  module Patterns
    module SpecificationActiveRecord
      # Abstract base class for all ActiveRecord specifications, providing class-level combinators for logical operations.
      #
      # This class is intended to be subclassed by concrete specifications and provides class-level methods for combining specifications.
      class CompositeSpecificationActiveRecord
        include SpecificationActiveRecord

        # Combines this specification with another using logical AND at the class level.
        #
        # @param other [SpecificationActiveRecord] The other specification to combine with.
        # @return [AndSpecificationActiveRecord] A new AND composite specification.
        def self.and(other)
          instance = ensure_instance(other)
          new.and(instance)
        end

        # Combines this specification with another using logical AND NOT at the class level.
        #
        # @param other [SpecificationActiveRecord] The other specification to negate and combine with.
        # @return [AndNotSpecificationActiveRecord] A new AND NOT composite specification.
        def self.and_not(other)
          instance = ensure_instance(other)
          new.and_not(instance)
        end

        # Combines this specification with another using logical OR at the class level.
        #
        # @param other [SpecificationActiveRecord] The other specification to combine with.
        # @return [OrSpecificationActiveRecord] A new OR composite specification.
        def self.or(other)
          instance = ensure_instance(other)
          new.or(instance)
        end

        # Combines this specification with another using logical OR NOT at the class level.
        #
        # @param other [SpecificationActiveRecord] The other specification to negate and combine with.
        # @return [OrNotSpecificationActiveRecord] A new OR NOT composite specification.
        def self.or_not(other)
          instance = ensure_instance(other)
          new.or_not(instance)
        end

        # Returns the negation of this specification at the class level.
        #
        # @return [NotSpecificationActiveRecord] A new negated specification.
        def self.not
          new.not
        end

        class << self
          private

          # Ensures the provided object is an instance of a specification and includes the SpecificationActiveRecord module.
          #
          # @param other [Object] The object to check.
          # @return [SpecificationActiveRecord] The validated specification instance.
          def ensure_instance(other)
            instance = Utils.as_instance(other)

            Utils.ensure_instance_includes(instance, SpecificationActiveRecord)
          end
        end
      end
    end
  end
end
