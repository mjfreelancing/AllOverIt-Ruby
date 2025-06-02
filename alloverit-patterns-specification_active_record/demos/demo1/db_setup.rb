# frozen_string_literal: true

require "active_record"
require "sqlite3"
require_relative "models/number"

Number = Demo1::Models::Number

# Setup in-memory database
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

# Define schema
ActiveRecord::Schema.define do
  create_table :numbers, force: true do |t|
    t.integer :value
  end
end

# Seed data
(1..25).each { |n| Number.create!(value: n) }
