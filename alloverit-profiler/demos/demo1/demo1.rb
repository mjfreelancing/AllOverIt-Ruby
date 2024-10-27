# frozen_string_literal: true

require "alloverit/profiler"
require "alloverit/profiler/default_visitor"

module Demo1
  class << self
    def factorial(number)
      ::AllOverIt::Profiler.track("Input #{number}") do

        ::AllOverIt::Profiler.breadcrumb("Calculating #{number} * #{number - 1}!")

        result = number <= 1 ? 1 : number + factorial(number - 1)

        ::AllOverIt::Profiler.breadcrumb("Calculated #{number} * #{number - 1}! = #{result}")

        # Introduce a brief delay just for the benefit of profiling
        sleep(rand(0.02..0.04))

        result
      end
    end

    def profile_factorial(number)
      ::AllOverIt::Profiler.track("Factorial #{number}") do
        puts "#{number}! = #{factorial(number)}"
      end
    end

    def show_profile
      puts
      puts "Calculation breakdown:"
      puts "======================"

      visitor = ::AllOverIt::Profiler::DefaultVisitor.new(logger: method(:puts))
      ::AllOverIt::Profiler.accept_visitor(visitor)
    end
  end

  options = {
    # Defaults to "default"
    key_lookup: -> { Thread.current.native_thread_id },

    # Defaults to false. When true, can use start so cleanup is called automatically, or explicitly call cleanup
    cleanup: true
  }

  # Using 'start' with options[:cleanup] results in the profile data being automatically removed
  ::AllOverIt::Profiler.start(options) do
    profile_factorial(8)
    show_profile
  end
end
