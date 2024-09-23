# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/pipeline/pipeline_step"

module Demo2
  class ValidateMaxStep < AllOverIt::Patterns::Pipeline::PipelineStep
    def initialize(upper_limit)
      super()
      @upper_limit = upper_limit
    end

    def call(input)
      value = input[:value]
      input[:errors] << "#{value} exceeds the maximum limit of #{@upper_limit}" if value > @upper_limit
      input
    end
  end
end
