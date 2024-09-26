# frozen_string_literal: true

require_relative "../../lib/alloverit/patterns/pipeline"
require_relative "steps/double_step"
require_relative "steps/increment_step"
require_relative "steps/square_step"

PipelineStep = AllOverIt::Patterns::Pipeline::PipelineStep

module Demo1
  # This is equivalent to AllOverIt::Patterns::Pipeline::Pipeline.new
  pipeline = AllOverIt::Patterns::Pipeline.create

  # Each call to #step below mutates the pipeline definition

  # Start the pipeline by multiplying the input by 3, using a block
  pipeline.step do |input|
    puts "  => input = #{input}, will * 3 via a block"
    input * 3
  end

  pipeline.step(IncrementStep.new)
          .step(DoubleStep.new)
          .step(SquareStep.new)

  pipeline.step do |value|
    puts "  => input = #{value} Will decrement via a block"
    value - 1
  end

  input = 1
  result = pipeline.call(input)

  puts "Pushed #{input} through to a value of #{result}"
end
