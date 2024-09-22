# frozen_string_literal: true
# rubocop:disable all

require "bundler/setup"
require_relative "specifications/is_even_number"
require_relative "specifications/is_less_than"

module Demo1
  EvenNumberSpecification = Demo1::Specifications::IsEvenNumber
  LessThanSpecification = Demo1::Specifications::IsLessThan

  even_spec = EvenNumberSpecification.new
  less_than_twenty_spec = LessThanSpecification.new(20)

  combined_spec = even_spec.and(less_than_twenty_spec)

  numbers = [10, 15, 20, 22, 8]

  numbers.each do |number|
    if combined_spec.satisfied_by?(number)
      puts "#{number} satisfies the combined specification"
    else
      puts "#{number} does not satisfy the combined specification"
    end
  end
end
