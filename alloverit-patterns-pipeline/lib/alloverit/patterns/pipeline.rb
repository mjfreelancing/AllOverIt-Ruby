# frozen_string_literal: true

require_relative "pipeline/pipeline_step"

module AllOverIt
  module Patterns
    module Pipeline
      def self.create
        Pipeline.new
      end

      class Pipeline
        class BlockStep < PipelineStep
          def initialize(&block)
            super()
            @block = block
          end

          def call(input = nil)
            @block.call(input)
          end
        end

        private_constant :BlockStep

        def initialize
          @steps = []
        end

        # pipeline_step can be an instance of PipelineStep or any other class that responds to :call(input) and
        # returns the output to be provided to the next step.
        #
        # block, if provided, must accept an 'input' and return the output to be provided to the next step.
        def step(pipeline_step = nil, &block)
          if block_given?
            raise ArgumentError, "Cannot provide both a pipeline step and a block" if pipeline_step

            pipeline_step = BlockStep.new(&block)
          end

          unless pipeline_step.is_a?(PipelineStep) || (pipeline_step.respond_to?(:call) && pipeline_step.method(:call).arity == 1)
            raise ArgumentError, "A pipeline step must inherit #{PipelineStep.name} or have a call method that accepts exactly one argument"
          end

          @steps << pipeline_step
          self
        end

        def call(input)
          @steps.reduce(input) do |current_input, step|
            step.call(current_input)
          end
        end
      end
    end
  end
end
