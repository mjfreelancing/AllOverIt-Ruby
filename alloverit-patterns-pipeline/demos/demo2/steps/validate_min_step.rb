# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/pipeline/pipeline_step"

module Demo2
  class ValidateMinStep < AllOverIt::Patterns::Pipeline::PipelineStep
    def initialize(lower_limit)
      super()
      @lower_limit = lower_limit
    end

    def call(input)
      value = input[:value]
      input[:errors] << "#{value} exceeds the minimum limit of #{@lower_limit}" if value < @lower_limit
      input
    end
  end
end
