# frozen_string_literal: true

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end

Dir[File.expand_path("../lib/**/*.rb", File.dirname(__FILE__))].sort.each { |f| require f }
Dir[File.expand_path("support/**/*.rb", File.dirname(__FILE__))].sort.each { |f| require f }

TrueSpecification = Support::AllOverIt::Patterns::Specification::TrueSpecification
FalseSpecification = Support::AllOverIt::Patterns::Specification::FalseSpecification
BadSpecification = Support::AllOverIt::Patterns::Specification::BadSpecification
