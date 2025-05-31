# frozen_string_literal: true

require_relative "specifications/is_even_number"
require_relative "specifications/is_less_than"

module Demo1
  EvenNumberSpecification = Demo1::Specifications::IsEvenNumber
  LessThanSpecification = Demo1::Specifications::IsLessThan

  even_spec = EvenNumberSpecification.new
  less_than_twenty_spec = LessThanSpecification.new(20)

  combined_spec = even_spec.and(less_than_twenty_spec)

  puts
  puts
  puts "Specification: #{combined_spec}"
  puts

  numbers = (1..25)

  # Individual checks
  puts "Individually..."
  numbers.each do |number|
    if combined_spec.satisfied_by?(number)
      puts "#{number} satisfies the combined specification"
    else
      puts "#{number} does not satisfy the combined specification"
    end
  end
  puts
  puts

  # Applied as a predicate
  puts "As a predicate..."
  # Equivalent to: matches = numbers.select(&combined_spec.method(:satisfied_by?))
  matches = numbers.select { |number| combined_spec.satisfied_by?(number) }
  
  puts "Results: #{matches}"
  puts
  puts

end
