# frozen_string_literal: true

require_relative "pipeline/pipeline_step"

module AllOverIt
  module Patterns
    # Provides a pipeline pattern implementation, allowing a sequence of steps to be executed where each step receives the output of the previous one.
    # Steps can be custom classes inheriting from PipelineStep, or any object responding to `call(input)`.
    #
    # Example usage:
    #   pipeline = AllOverIt::Patterns::Pipeline.create
    #   pipeline.step { |input| input + 1 }
    #   pipeline.step(MyCustomStep.new)
    #   result = pipeline.call(5)
    #
    # @see AllOverIt::Patterns::Pipeline::PipelineStep
    module Pipeline
      # Creates a new Pipeline instance.
      #
      # @return [Pipeline] A new pipeline instance.
      def self.create
        Pipeline.new
      end

      # Implements a pipeline that processes input through a sequence of steps.
      class Pipeline
        # A pipeline step that wraps a block.
        class BlockStep < PipelineStep
          # Initializes a BlockStep with a block.
          #
          # @yieldparam input [Object] The input to the block.
          def initialize(&block)
            super()
            @block = block
          end

          # Calls the block with the given input.
          #
          # @param input [Object] The input to the block.
          # @return [Object] The result of the block.
          def call(input = nil)
            @block.call(input)
          end
        end

        private_constant :BlockStep

        # Initializes a new Pipeline instance.
        def initialize
          @steps = []
        end

        # Adds a step to the pipeline.
        #
        # @param pipeline_step [PipelineStep, #call] An instance of PipelineStep or any object responding to `call(input)`.
        # @yield [input] Optional block to be used as a pipeline step.
        # @yieldparam input [Object] The input to the block.
        # @raise [ArgumentError] If both a pipeline_step and block are provided, or if the step does not meet requirements.
        # @return [self]
        def step(pipeline_step = nil, &block)
          if block_given?
            raise ArgumentError, "Cannot provide both a pipeline step and a block" if pipeline_step

            pipeline_step = BlockStep.new(&block)
          end

          # rubocop:disable Style/IfUnlessModifier
          unless pipeline_step.is_a?(PipelineStep) || (pipeline_step.respond_to?(:call) && pipeline_step.method(:call).arity == 1)
            raise ArgumentError, "A pipeline step must inherit #{PipelineStep.name} or have a call method that accepts exactly one argument"
          end
          # rubocop:enable Style/IfUnlessModifier

          @steps << pipeline_step
          self
        end

        # Executes the pipeline with the given input.
        #
        # @param input [Object] The initial input to the pipeline.
        # @return [Object] The result after processing through all steps.
        def call(input)
          @steps.reduce(input) do |current_input, step|
            step.call(current_input)
          end
        end
      end
    end
  end
end
