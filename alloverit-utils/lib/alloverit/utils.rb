# frozen_string_literal: true

require_relative "utils/check"

# The top-level namespace for AllOverIt utilities and helpers.
module AllOverIt
  # Utility methods for AllOverIt, including instance and type checking helpers.
  module Utils
    # Returns an instance of the provided class, or the object itself if already an instance.
    #
    # @param instance_or_class [Class, Object] A class or an instance.
    # @return [Object] An instance of the provided class or the original object if it was already an instance.
    def self.as_instance(instance_or_class)
      Check.not_nil(instance_or_class: instance_or_class)

      instance_or_class.is_a?(Class) ? instance_or_class.new : instance_or_class
    end

    # Ensures the provided instance includes the specified module in its ancestor chain.
    #
    # @param instance [Object] The object to check.
    # @param module_type [Module] The module to check for in the ancestor chain.
    # @return [Object] The original instance if it includes the module, otherwise raises ArgumentError.
    def self.ensure_instance_includes(instance, module_type)
      Check.not_nil(instance: instance, module_type: module_type)

      raise ArgumentError, "Expected #{instance.class} to include #{module_type.name}" unless instance.class.ancestors.include?(module_type)

      instance
    end

    # Ensures the provided instance is a kind of the specified class.
    #
    # @param instance [Object] The object to check.
    # @param class_type [Class] The class to check for inheritance.
    # @return [Object] The original instance if it is a kind of the class, otherwise raises ArgumentError.
    def self.ensure_instance_is_a(instance, class_type)
      Check.not_nil(instance: instance, class_type: class_type)

      raise ArgumentError, "Expected #{instance.class} to inherit #{class_type.name}" unless instance.is_a?(class_type)

      instance
    end
  end
end
