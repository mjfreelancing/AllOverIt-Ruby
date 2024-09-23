# frozen_string_literal: true

module AllOverIt
  module Patterns
    module ChainOfResponsibility
      class ChainOfResponsibilityHandler
        def initialize
          if instance_of?(ChainOfResponsibilityHandler)
            raise NotImplementedError, "ChainOfResponsibilityHandler is abstract."
          end

          @next_handler = nil
        end

        def set_next(handler)
          raise ArgumentError, "A Chain Of Responsibility handler cannot be nil." if handler.nil?

          @next_handler = handler
          handler
        end

        def handle(request)
          return nil if @next_handler.nil?

          @next_handler.handle(request)
        end
      end
    end
  end
end
