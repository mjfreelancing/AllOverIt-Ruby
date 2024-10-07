# frozen_string_literal: true

module AllOverIt
  module Patterns
    module ChainOfResponsibility
      class ChainOfResponsibilityHandler
        class BlockHandler < ChainOfResponsibilityHandler
          def initialize(&block)
            super()
            @block = block
          end

          def handle(request = nil)
            result = @block.call(request)

            result.nil? ? super : result
          end
        end

        private_constant :BlockHandler

        def initialize
          raise NotImplementedError, "ChainOfResponsibilityHandler is abstract" if instance_of?(ChainOfResponsibilityHandler)

          @next_handler = nil
        end

        def next_handler(handler = nil, &block)
          if block_given?
            raise ArgumentError, "Cannot provide both a handler and a block" if handler

            handler = BlockHandler.new(&block)
          end

          unless handler.is_a?(ChainOfResponsibilityHandler) || (handler.respond_to?(:call) && handler.method(:call).arity == 1)
            raise ArgumentError, "A Chain of Responsibility handler must inherit #{ChainOfResponsibilityHandler.name} or have a call method that accepts exactly one argument"
          end

          @next_handler = handler
          handler
        end

        # Attempts to handle the provided request.
        # @param request [Object] The request object that the handler will attempt to handle.
        # @return Any non-nil result indicates the request was handled. This allows a custom state to be returned.
        #   If nil is returned then the next handler in the chain will be provided the request. If all handlers
        #   are unable to process the request then the final result returned will be nil?
        def handle(request)
          @next_handler&.handle(request)
        end
      end
    end
  end
end
