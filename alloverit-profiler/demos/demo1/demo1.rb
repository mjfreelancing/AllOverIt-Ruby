# frozen_string_literal: true

require "alloverit/profiler"

module Demo1
  class << self
    def factorial(number)
      ::AllOverIt::Profiler.call("Input #{number}") do
        return 1 if number <= 1

        result = number + factorial(number - 1)

        ::AllOverIt::Profiler.breadcrumb("#{number} * #{number - 1}! = #{result}")

        result
      end
    end
  end

  number = 8

  ::AllOverIt::Profiler.call("Factorial #{number}", root: true) do
    puts "#{number}! = #{factorial(number)}"
    # fibonacci(7)
  end

  puts
  puts "Calculation breakdown:"
  puts "======================"

  visitor = ::AllOverIt::DefaultProfilerVisitor.new(logger: method(:puts))
  ::AllOverIt::Profiler.accept_visitor(visitor)
end
