# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/pipeline/pipeline_step"

module Demo1
  class SquareStep < Alloverit::Patterns::Pipeline::PipelineStep
    # For this demo, not mutating the input
    def execute(input)
      puts "  => input = #{input}, will square"
      input * input
    end
  end
end
