# frozen_string_literal: true

require "alloverit/profiler"

module Demo1
  class << self
    def factorial(number)
      ::AllOverIt::Profiler.call("Input #{number}") do
        result = number <= 1 ? 1 : number + factorial(number - 1)

        ::AllOverIt::Profiler.breadcrumb("#{number} * #{number - 1}! = #{result}")

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
