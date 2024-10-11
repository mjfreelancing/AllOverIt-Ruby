# frozen_string_literal: true

require_relative "../../lib/alloverit/patterns/pipeline/pipeline_step"

class DummyStep < AllOverIt::Patterns::Pipeline::PipelineStep
  def initialize(factor = 1)
    super()
    @factor = factor
  end

  def call(input)
    input * @factor
  end
end
