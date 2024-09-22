# frozen_string_literal: true

require_relative "pipeline/pipeline_step"

module Alloverit
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

          def execute(input = nil)
            @block.call(input)
          end
        end

        def initialize
          @steps = []
        end

        def step(pipeline_step = nil, &block)
          if block_given?
            raise ArgumentError, "Cannot provide both a pipeline step and a block" if pipeline_step

            pipeline_step = BlockStep.new(&block)
          end

          unless pipeline_step.is_a?(PipelineStep)
            raise ArgumentError, "A pipeline step must inherit #{PipelineStep.name}"
          end

          @steps << pipeline_step
          self
        end

        def call(input)
          @steps.reduce(input) do |current_input, step|
            step.execute(current_input)
          end
        end
      end
    end
  end
end
