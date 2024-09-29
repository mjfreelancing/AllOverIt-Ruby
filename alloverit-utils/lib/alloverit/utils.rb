# frozen_string_literal: true

require_relative "utils/check"

module AllOverIt
  module Utils
    # This class method checks whether the argument is a class or an instance.
    # If a class is provided, it returns a default initialized instance of the class.
    # If an instance is provided, it returns the instance as is.
    #
    # @param instance_or_class [Class, Object] A class or an instance.
    # @return [Object] An instance of the provided class or the original object
    #   if it was already an instance.
    def self.as_instance(instance_or_class)
      Check.not_nil(instance_or_class: instance_or_class)

      instance_or_class.is_a?(Class) ? instance_or_class.new : instance_or_class
    end

    # This class method checks that an instance variable includes a specified module. The instance is returned
    # if its' ancestor chain includes the module, otherwise an ArgumentError is raised.
    #
    # @param instance [Object] The object to check if its' class ancestor chain includes the specified class_type.
    # @param class_type [Class] The class type to check exists in the ancestor chain of the provided instance.
    # @return The original instance if its ancestor chain includes the specified class_type,
    #   otherwise an ArgumentError is raised.
    def self.ensure_instance_includes(instance, module_type)
      Check.not_nil(instance: instance, module_type: module_type)

      raise ArgumentError, "Expected #{instance.class} to include #{module_type.name}" unless instance.class.ancestors.include?(module_type)

      instance
    end

    # This class method checks that an instance variable inherits a specified class. The instance is returned
    # if it inherits the specified class, otherwise an ArgumentError is raised.
    #
    # @param instance [Object] The object to check if it is of, or inherits, the specified class_type.
    # @param class_type [Class] The class type to check is a super class of the provided instance.
    # @return The original instance if it is of, or inherits, the specified class_type,
    #   otherwise an ArgumentError is raised.
    def self.ensure_instance_is_a(instance, class_type)
      Check.not_nil(instance: instance, class_type: class_type)

      raise ArgumentError, "Expected #{instance.class} to inherit #{class_type.name}" unless instance.is_a?(class_type)

      instance
    end
  end
end
