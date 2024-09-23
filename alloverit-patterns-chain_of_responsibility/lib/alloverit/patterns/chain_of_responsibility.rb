# frozen_string_literal: true

require_relative "../utils"

module AllOverIt
  module Patterns
    module ChainOfResponsibility
      def self.compose(handlers)
        raise ArgumentError, "The handlers must be an array." unless handlers.is_a?(Array)
        raise ArgumentError, "The handlers cannot be null or empty." if handlers.empty?

        first_handler = Utils.ensure_instance(handlers.first)

        handlers[1..].reduce(first_handler) do |current, handler|
          next_handler = Utils.ensure_instance(handler)
          current.set_next(next_handler)
        end

        first_handler
      end
    end
  end
end
