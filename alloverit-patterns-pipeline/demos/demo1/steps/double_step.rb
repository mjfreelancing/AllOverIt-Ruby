# frozen_string_literal: true

require "alloverit/patterns/pipeline"

module Demo1
  class DoubleStep < AllOverIt::Patterns::Pipeline::PipelineStep
    # For this demo, not mutating the input
    def call(input)
      puts "  => input = #{input}, will double via a step"
      input * 2
    end
  end
end
