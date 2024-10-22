# frozen_string_literal: true

require "alloverit/profiler"

module Demo1
  class << self
    def factorial(number)
      ::AllOverIt::Profiler.call("Input #{number}") do

        ::AllOverIt::Profiler.breadcrumb("Calculating #{number} * #{number - 1}!")

        result = number <= 1 ? 1 : number + factorial(number - 1)

        ::AllOverIt::Profiler.breadcrumb("Calculated #{number} * #{number - 1}! = #{result}")

        # Introduce a brief delay just for the benefit of profiling
        sleep(rand(0.02..0.04))

        result
      end
    end
  end

  number = 8

  ::AllOverIt::Profiler.call("Factorial #{number}", root: true) do
    puts "#{number}! = #{factorial(number)}"
  end

  puts
  puts "Calculation breakdown:"
  puts "======================"

  visitor = ::AllOverIt::DefaultProfilerVisitor.new(logger: method(:puts))
  ::AllOverIt::Profiler.accept_visitor(visitor)
end
