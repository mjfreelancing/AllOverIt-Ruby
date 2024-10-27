# frozen_string_literal: true

require "alloverit/profiler"
require "alloverit/profiler/default_visitor"

module Demo2
  class << self
    def bubble_sort(arr)
      n = arr.length

      (n - 1).times do |i|
        ::AllOverIt::Profiler.track("Pass #{i + 1}") do
          swapped = false

          (n - i - 1).times do |j|
            ::AllOverIt::Profiler.track("Comparing elements at positions #{j} and #{j + 1}") do
              if arr[j] > arr[j + 1]
                ::AllOverIt::Profiler.breadcrumb("Swapping elements #{arr[j]} and #{arr[j + 1]}")
                arr[j], arr[j + 1] = arr[j + 1], arr[j]
                swapped = true

                ::AllOverIt::Profiler.breadcrumb("Array after swap: #{arr.inspect}")
              else
                ::AllOverIt::Profiler.breadcrumb("No swap needed for elements #{arr[j]} and #{arr[j + 1]}")
              end
            end

            # Introduce a brief delay just for the benefit of profiling
            sleep(rand(0.02..0.04))
          end

          break unless swapped
        end
      end
    end

    def profile_bubble_sort(arr)
      ::AllOverIt::Profiler.track("Bubble sort the array: #{arr.inspect}") do
        bubble_sort(arr) # mutates the array
      end
    end

    def show_profile
      puts
      puts "Sort Breakdown:"
      puts "==============="

      visitor = ::AllOverIt::Profiler::DefaultVisitor.new(logger: method(:puts))
      ::AllOverIt::Profiler.accept_visitor(visitor)
    end
  end

  # Will use default options, including using "Default" for the key lookup,
  # and will not automatically cleanup the profile data
  ::AllOverIt::Profiler.start do
    arr = [64, 34, 25, 12, 22, 11, 90]
    profile_bubble_sort(arr)
  end

  # Doing this outside the scope of #start to show the data is still available
  show_profile

  # Optional since the app is finished
  ::AllOverIt::Profiler.cleanup
end
