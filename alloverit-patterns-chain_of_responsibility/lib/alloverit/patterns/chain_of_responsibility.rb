# frozen_string_literal: true

require "alloverit/utils"

module AllOverIt
  module Patterns
    module ChainOfResponsibility
      # handlers is an array of ChainOfResponsibilityHandler instances or class types
      def self.compose(*handlers)
        raise ArgumentError, "The handlers cannot be null or empty." if handlers.nil? || handlers.empty?

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
