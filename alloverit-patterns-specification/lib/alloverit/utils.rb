# frozen_string_literal: true

# TODO: to be moved to a Utils gem
module AllOverIt
  module Utils
    # @param instance_or_class An instance of an object or a class type.
    # @return The original instance if not a Class type, otherwise a newly constructed instance of the Class type.
    def self.as_instance(instance_or_class)
      instance_or_class.is_a?(Class) ? instance_or_class.new : instance_or_class
    end

    # @param The object to check if its' class ancestors include the specified class_type.
    # @param class_type The class type to check exists in the ancestor chain of the provided instance.
    # @return The original instance if its ancestor chain includes the specified class_type.
    # @raise ArgumentError When the instance's ancestor chain does not include the specified class_type.
    def self.ensure_instance_includes(instance, class_type)
      unless instance.class.ancestors.include?(class_type)
        raise ArgumentError, "Expected #{instance.class} to include #{class_type.name}"
      end

      instance
    end

    # @param The object to check if it inherits the specified class_type.
    # @param class_type The class type is a super class of the provided instance.
    # @return The original instance if it inherits the specified class_type.
    # @raise ArgumentError When the instance does not inherit the specified class_type.
    def self.ensure_instance_is_a(instance, class_type)
      unless instance.is_a?(class_type)
        raise ArgumentError, "Expected #{instance.class} to inherit #{class_type.name}"
      end

      instance
    end
  end
end
