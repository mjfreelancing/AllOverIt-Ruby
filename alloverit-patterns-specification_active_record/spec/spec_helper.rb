# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  track_files 'lib/**/*.rb'
  add_filter '/spec/'
end

require_relative "../lib/alloverit/patterns/specification_active_record"
require_relative 'support/widget'
require 'active_record'
require 'database_cleaner/active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:'
)

ActiveRecord::Schema.define do
  create_table :widgets, force: true do |t|
    t.string :name
    t.integer :value
  end
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning { example.run }
  end
end
