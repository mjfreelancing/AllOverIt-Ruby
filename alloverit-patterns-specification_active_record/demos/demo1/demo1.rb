# frozen_string_literal: true

require "active_record"
require "sqlite3"
require_relative "../../lib/alloverit/patterns/specification_active_record/specification_scopeable"
require_relative "models/number"
require_relative "db_setup"
require_relative "specifications/is_even_number"
require_relative "specifications/is_less_than"

puts
puts
puts "Numbers seeded in the database: #{Number.all.pluck(:value).join(", ")}"
puts

puts "DATABASE Querying (scoped_to)"
puts "-----------------------------"
puts

EvenNumber = Demo1::Specifications::IsEvenNumber
LessThan = Demo1::Specifications::IsLessThan

# Create initial specifications
even_spec = EvenNumber.new
less_than_twenty_spec = LessThan.new(20)
combined_spec = even_spec.and(less_than_twenty_spec)
negated_spec = combined_spec.not

# Use ActiveRecord query via the scoped_to concern
results = Number.scoped_to(combined_spec)
puts "SQL for combined_spec: #{results.to_sql}"
puts "Numbers that are #{combined_spec}: #{results.pluck(:value).join(", ")}"
puts

negated_results = Number.scoped_to(negated_spec)
puts "SQL for negated_spec: #{negated_results.to_sql}"
puts "Numbers that are #{negated_spec}: #{negated_results.pluck(:value).join(", ")}"
puts
puts

puts "MEMORY Querying (satisfied_by?)"
puts "-------------------------------"

in_memory_results = Number.all.select { |n| combined_spec.satisfied_by?(n) }
puts "Numbers that are #{combined_spec}: #{in_memory_results.map(&:value).join(", ")}"
puts

in_memory_results = Number.all.select { |n| negated_spec.satisfied_by?(n) }
puts "Numbers that are #{negated_spec}: #{in_memory_results.map(&:value).join(", ")}"
puts
