# frozen_string_literal: true

require_relative "../../lib/alloverit/patterns/pipeline"
require_relative "steps/validate_min_step"
require_relative "steps/validate_max_step"
require_relative "steps/validate_even_step"

PipelineStep = AllOverIt::Patterns::Pipeline::PipelineStep

module Demo2
  # This is equivalent to AllOverIt::Patterns::Pipeline::Pipeline.new
  pipeline = AllOverIt::Patterns::Pipeline.create

  # Each call to #step below mutates the pipeline definition

  pipeline.step(ValidateMinStep.new(10))
          .step(ValidateMaxStep.new(20))
          .step(ValidateEvenStep.new)

  puts "Checking between 5 and 26, testing for 10 <= n <= 20 and must be even"
  puts

  (5..26).step(3) do |i|
    input = {
      value: i,
      errors: []
    }

    result = pipeline.call(input)

    if result[:errors].empty?
      puts "Test passed for input value #{i}. SUCCESS."
    else
      puts "Test failed for input value #{i}. Errors: #{result[:errors].join(", ")}"
    end
  end
end
