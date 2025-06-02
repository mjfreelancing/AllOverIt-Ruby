# frozen_string_literal: true

module AllOverIt
  module Patterns
    module ChainOfResponsibility
      # ChainOfResponsibilityHandler provides an abstract base for implementing the Chain of Responsibility pattern.
      # It allows chaining of handlers, each of which can process a request or pass it to the next handler in the chain.
      class ChainOfResponsibilityHandler
        # BlockHandler is a concrete handler that wraps a block for request processing in the chain.
        # It allows inline handling logic to be provided as a block, which is called with the request.
        # If the block returns nil, the request is passed to the next handler in the chain.
        class BlockHandler < ChainOfResponsibilityHandler
          # Initializes a new BlockHandler with a block to handle requests.
          # @param block [Proc] The block that will attempt to handle the request.
          def initialize(&block)
            super()
            @block = block
          end

          # Attempts to handle the provided request using the block.
          # @param request [Object] The request object to handle.
          # @return [Object, nil] The result of the block, or passes to the next handler if nil.
          def handle(request = nil)
            result = @block.call(request)

            result.nil? ? super : result
          end
        end

        private_constant :BlockHandler

        # Initializes a new handler. This class is abstract and cannot be instantiated directly.
        # @raise [NotImplementedError] if instantiated directly.
        def initialize
          raise NotImplementedError, "ChainOfResponsibilityHandler is abstract" if instance_of?(ChainOfResponsibilityHandler)

          @next_handler = nil
        end

        # Sets the next handler in the chain.
        # @param handler [ChainOfResponsibilityHandler, #call] The next handler or a callable object.
        # @yield [request] Optional block to handle the request if no handler is provided.
        # @return [ChainOfResponsibilityHandler] The handler that was set as next.
        # @raise [ArgumentError] if both a handler and a block are provided, or if handler is invalid.
        def next_handler(handler = nil, &block)
          if block_given?
            raise ArgumentError, "Cannot provide both a handler and a block" if handler

            handler = BlockHandler.new(&block)
          end

          # rubocop:disable Style/IfUnlessModifier
          unless handler.is_a?(ChainOfResponsibilityHandler) || (handler.respond_to?(:call) && handler.method(:call).arity == 1)
            raise ArgumentError, "A Chain of Responsibility handler must inherit #{ChainOfResponsibilityHandler.name} or have a call method that accepts exactly one argument"
          end
          # rubocop:enable Style/IfUnlessModifier

          @next_handler = handler
          handler
        end

        # Attempts to handle the provided request.
        # @param request [Object] The request object that the handler will attempt to handle.
        # @return [Object, nil] Any non-nil result indicates the request was handled. If nil is returned then the next
        #  handler in the chain will be provided the request. If all handlers are unable to process the request then the
        #  final result returned will be nil.
        def handle(request)
          @next_handler&.handle(request)
        end
      end
    end
  end
end
