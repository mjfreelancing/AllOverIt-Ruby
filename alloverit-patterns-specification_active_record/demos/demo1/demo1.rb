# frozen_string_literal: true

require 'active_record'
require 'sqlite3'
require_relative "../../lib/alloverit/patterns/specification_active_record/specification_scopeable"
require_relative "specifications/is_even_number"
require_relative "specifications/is_less_than"

# Setup in-memory database
ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

# Define schema
ActiveRecord::Schema.define do
  create_table :numbers, force: true do |t|
    t.integer :value
  end
end

# Define model
class Number < ActiveRecord::Base
  include AllOverIt::Patterns::SpecificationActiveRecord::SpecificationScopeable
end

# Define specifications
EvenNumberSpecification = Demo1::Specifications::IsEvenNumber
LessThanSpecification = Demo1::Specifications::IsLessThan

# Seed data
(1..25).each { |n| Number.create!(value: n) }

puts
puts
puts "Numbers seeded in the database: #{Number.all.pluck(:value).join(', ')}"
puts

puts 'DATABASE Querying (scoped_to)'
puts '-----------------------------'
puts

# Create initial specifications
even_spec = EvenNumberSpecification.new
less_than_twenty_spec = LessThanSpecification.new(20)
combined_spec = even_spec.and(less_than_twenty_spec)
negated_spec = combined_spec.not

# Use ActiveRecord query via the scoped_to concern
results = Number.scoped_to(combined_spec)
puts "Numbers that are #{combined_spec}: #{results.pluck(:value).join(', ')}"
puts

negated_results = Number.scoped_to(negated_spec)
puts "Numbers that are #{negated_spec}: #{negated_results.pluck(:value).join(', ')}"
puts
puts

puts 'MEMORY Querying (satisfied_by?)'
puts '-------------------------------'

in_memory_results = Number.all.select { |n| combined_spec.satisfied_by?(n) }
puts "Numbers that are #{combined_spec}: #{in_memory_results.map(&:value).join(', ')}"
puts

in_memory_results = Number.all.select { |n| negated_spec.satisfied_by?(n) }
puts "Numbers that are #{negated_spec}: #{in_memory_results.map(&:value).join(', ')}"
puts
