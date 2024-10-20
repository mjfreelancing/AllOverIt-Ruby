# frozen_string_literal: true

require "alloverit/patterns/pipeline"

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
