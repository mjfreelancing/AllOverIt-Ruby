# frozen_string_literal: true

module AllOverIt
  module Patterns
    module Pipeline
      class PipelineStep
        def call(input = nil)
          raise NotImplementedError, "'#{self.class}' has not implemented '#{__method__}'."
        end
      end
    end
  end
end
