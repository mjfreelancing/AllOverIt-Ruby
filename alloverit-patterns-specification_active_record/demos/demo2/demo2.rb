# frozen_string_literal: true

require "active_record"
require "sqlite3"
require_relative "../../lib/alloverit/patterns/specification_active_record/specification_scopeable"
require_relative "models/chilli"
require_relative "specifications/has_color"
require_relative "specifications/has_origin"
require_relative "specifications/is_mild"
require_relative "db_setup"

Chilli = Demo2::Models::Chilli

# Alias the specification classes for easier use
HasColor = Demo2::Specifications::HasColor
HasOrigin = Demo2::Specifications::HasOrigin
IsMild = Demo2::Specifications::IsMild

# Compose specifications
not_green_spec = HasColor.new("green").not
mexico_or_india_spec = HasOrigin.new("mexico").or(HasOrigin.new("india"))
combined_spec = IsMild.or(not_green_spec.and(mexico_or_india_spec))
negated_spec = combined_spec.not

puts
puts
puts "Chillis seeded in the database"
puts "------------------------------"

Chilli.all.each do |chilli|
  puts "Name: #{chilli.name}, Origin: #{chilli.origin}, Colors: #{chilli.color_list.join(", ")}, Scoville Range: #{chilli.scoville_range}"
end

puts
puts
puts "Not Green Specification      : #{not_green_spec}"
puts "Mexico or India Specification: #{mexico_or_india_spec}"
puts "Mild Specification           : #{IsMild.new}"
puts
puts
puts "DATABASE Querying (scoped_to)"
puts "------------------------------"

# ActiveRecord query using scoped_to
results = Chilli.scoped_to(combined_spec)
puts "SQL for combined_spec: #{results.to_sql}"
puts "Chillis that are #{combined_spec}:"

results.each do |chilli|
  puts "  Name: #{chilli.name}, Origin: #{chilli.origin}, Colors: #{chilli.color_list.join(", ")}, Scoville Range: #{chilli.scoville_range}"
end

puts
puts

results = Chilli.scoped_to(negated_spec)
puts "SQL for negated_spec: #{results.to_sql}"
puts "Chillis that are #{negated_spec}:"

results.each do |chilli|
  puts "  Name: #{chilli.name}, Origin: #{chilli.origin}, Colors: #{chilli.color_list.join(", ")}, Scoville Range: #{chilli.scoville_range}"
end

puts
puts

puts "MEMORY Querying (satisfied_by?)"
puts "-------------------------------"
puts
puts "Chillis that are #{combined_spec}:"

Chilli.all.each do |chilli|
  if combined_spec.satisfied_by?(chilli)
    puts "  Name: #{chilli.name}, Origin: #{chilli.origin}, Colors: #{chilli.color_list.join(", ")}, Scoville Range: #{chilli.scoville_range}"
  end
end

puts
puts

puts "Chillis that are #{negated_spec}:"
Chilli.all.each do |chilli|
  if negated_spec.satisfied_by?(chilli)
    puts "  Name: #{chilli.name}, Origin: #{chilli.origin}, Colors: #{chilli.color_list.join(", ")}, Scoville Range: #{chilli.scoville_range}"
  end
end

puts
puts
