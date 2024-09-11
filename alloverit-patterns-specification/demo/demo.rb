#!/usr/bin/env ruby
# frozen_string_literal: true

require "bundler/setup"
require_relative "../lib/alloverit/patterns/specification/specification"
require_relative "../lib/alloverit/patterns/specification/composite_specification"

# You can add fixtures and/or initialization code here to make experimenting
# with your gem easier. You can also use a different console, if you like.

# require "irb"
# IRB.start(__FILE__)

class EvenNumberSpecification < Alloverit::Patterns::Specification::CompositeSpecification
  def satisfied_by?(candidate)
    candidate.is_a?(Integer) && candidate.even?
  end
end

class LessThanTwentySpecification < Alloverit::Patterns::Specification::CompositeSpecification
  def satisfied_by?(candidate)
    candidate.is_a?(Integer) && candidate < 20
  end
end

even_spec = EvenNumberSpecification.new
less_than_twenty_spec = LessThanTwentySpecification.new

combined_spec = even_spec.and less_than_twenty_spec

numbers = [10, 15, 20, 22, 8]

numbers.each do |number|
  if combined_spec.satisfied_by?(number)
    puts "#{number} satisfies the combined specification"
  else
    puts "#{number} does not satisfy the combined specification"
  end
end
