# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/pipeline/pipeline_step"

module Demo1
  class IncrementStep < Alloverit::Patterns::Pipeline::PipelineStep
    def call(input)
      # For this demo, not mutating the input
      puts "  => input = #{input}, will increment"
      input + 1
    end
  end
end
