# frozen_string_literal: true

require "alloverit/patterns/pipeline"

module Demo1
  class SquareStep < AllOverIt::Patterns::Pipeline::PipelineStep
    # For this demo, not mutating the input
    def call(input)
      puts "  => input = #{input}, will square via a step"
      input * input
    end
  end
end
