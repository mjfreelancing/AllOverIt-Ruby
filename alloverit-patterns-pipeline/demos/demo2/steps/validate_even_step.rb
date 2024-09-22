# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/pipeline/pipeline_step"

module Demo2
  class ValidateEvenStep < Alloverit::Patterns::Pipeline::PipelineStep
    def execute(input)
      value = input[:value]
      input[:errors] << "#{value} is not an even number" if value.odd?
      input
    end
  end
end
