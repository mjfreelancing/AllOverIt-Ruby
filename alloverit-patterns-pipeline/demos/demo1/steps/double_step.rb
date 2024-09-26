# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/pipeline/pipeline_step"

module Demo1
  class DoubleStep < AllOverIt::Patterns::Pipeline::PipelineStep
    # For this demo, not mutating the input
    def call(input)
      puts "  => input = #{input}, will double via a step"
      input * 2
    end
  end
end
