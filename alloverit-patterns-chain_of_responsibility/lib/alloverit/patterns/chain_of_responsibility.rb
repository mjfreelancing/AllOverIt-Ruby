# frozen_string_literal: true

require "alloverit/utils"

module AllOverIt
  module Patterns
    module ChainOfResponsibility
      # This class method will compose a variable number of handlers into a linked list. Each handler can be a
      # class type that includes the ChainOfResponsibilityHandler module, or a previously initialized instance.
      #
      # @param handlers [Array<ChainOfResponsibilityHandler, Class>] A variable number of ChainOfResponsibilityHandler
      #   instances or class types.
      def self.compose(*handlers)
        raise ArgumentError, "The handlers cannot be empty." unless handlers.any?

        first_handler = AllOverIt::Utils.as_instance(handlers.first)

        handlers[1..].reduce(first_handler) do |current, handler|
          next_handler = Utils.as_instance(handler)
          current.next_handler(next_handler)
        end

        first_handler
      end
    end
  end
end
