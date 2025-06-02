# frozen_string_literal: true

require "active_record"
require "sqlite3"
require_relative "models/chilli"

Chilli = Demo2::Models::Chilli

# Setup in-memory database
ActiveRecord::Base.establish_connection(
  adapter: "sqlite3",
  database: ":memory:"
)

# Define schema
ActiveRecord::Schema.define do
  create_table :chillis, force: true do |t|
    t.string :name
    t.string :colors
    t.string :origin
    t.integer :scoville_lower
    t.integer :scoville_upper
  end
end

# Seed data
Chilli.create!(name: "Habanero", colors: "Orange,Red,White,Brown", origin: "Mexico", scoville_lower: 100_000,
               scoville_upper: 350_000)
Chilli.create!(name: "Bird's Eye", colors: "Red,Green", origin: "Thailand", scoville_lower: 50_000,
               scoville_upper: 100_000)
Chilli.create!(name: "Ghost Pepper", colors: "Red,Orange,Chocolate,Yellow", origin: "India", scoville_lower: 1_000_000,
               scoville_upper: 1_200_000)
Chilli.create!(name: "Jalapeño", colors: "Green,Red", origin: "Mexico", scoville_lower: 2_500, scoville_upper: 8_000)
Chilli.create!(name: "African Bird's Eye", colors: "Red", origin: "Africa", scoville_lower: 50_000,
               scoville_upper: 175_000)
