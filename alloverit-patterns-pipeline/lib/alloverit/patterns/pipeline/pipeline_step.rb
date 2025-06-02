# frozen_string_literal: true

module AllOverIt
  module Patterns
    module Pipeline
      # Defines the base class for a pipeline step in the Pipeline pattern.
      # Subclasses must implement the `call(input)` method to process input and return output.
      #
      # @abstract
      # @see AllOverIt::Patterns::Pipeline::Pipeline
      class PipelineStep
        # Processes the input and returns the output for the next step.
        #
        # @param input [Object] The input to the pipeline step.
        # @return [Object] The output to be passed to the next step.
        # @raise [NotImplementedError] If not implemented by a subclass.
        def call(input = nil)
          raise NotImplementedError, "'#{self.class}' has not implemented '#{__method__}'"
        end
      end
    end
  end
end
