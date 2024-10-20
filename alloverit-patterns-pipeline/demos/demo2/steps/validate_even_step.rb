# frozen_string_literal: true

require "alloverit/patterns/pipeline"

module Demo2
  class ValidateEvenStep < AllOverIt::Patterns::Pipeline::PipelineStep
    def call(input)
      value = input[:value]
      input[:errors] << "#{value} is not an even number" if value.odd?
      input
    end
  end
end
