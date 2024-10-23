# frozen_string_literal: true

require "alloverit/profiler"

module Demo2
  class << self
    def bubble_sort(arr)
      n = arr.length

      (n - 1).times do |i|
        ::AllOverIt::Profiler.call("Pass #{i + 1}") do
          swapped = false

          (n - i - 1).times do |j|
            ::AllOverIt::Profiler.call("Comparing elements at positions #{j} and #{j + 1}") do
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
  end

  arr = [64, 34, 25, 12, 22, 11, 90]

  ::AllOverIt::Profiler.call("Bubble sort the array: #{arr.inspect}", root: true) do
    bubble_sort(arr) # mutates the array
  end

  puts
  puts "Sort Breakdown:"
  puts "==============="

  visitor = ::AllOverIt::DefaultProfileVisitor.new(logger: method(:puts))
  ::AllOverIt::Profiler.accept_visitor(visitor)

end
