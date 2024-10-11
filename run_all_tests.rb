# frozen_string_literal: true

require 'simplecov'

project_dirs = Dir.glob('alloverit-*').select { |dir| File.directory?(dir) }

project_dirs.each do |project_dir|
  coverage_dir = File.join(project_dir, 'coverage')

  if Dir.exist?(coverage_dir)
    puts "Cleaning coverage folder for #{project_dir}..."
    FileUtils.rm_rf(coverage_dir) # Recursively remove the folder and its contents
  end

  puts "Running tests for #{project_dir}..."
  Dir.chdir(project_dir) do
    system('bundle exec rspec') or abort("Tests failed in #{project_dir}")
  end
end

puts 'Merging coverage results...'

SimpleCov.coverage_dir 'coverage/combined'

SimpleCov.collate Dir['alloverit*/coverage/**/.resultset.json'] do
  enable_coverage :branch
end

puts 'Combined coverage report generated in coverage/combined'
