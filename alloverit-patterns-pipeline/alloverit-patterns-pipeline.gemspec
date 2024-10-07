# frozen_string_literal: true

require_relative "lib/alloverit/patterns/pipeline/version"

Gem::Specification.new do |spec|
  spec.name = "alloverit-patterns-pipeline"
  spec.version = AllOverIt::Patterns::Pipeline::VERSION
  spec.authors = ["Malcolm Smith"]
  spec.email = ["malcolm@mjfreelancing.com"]

  spec.summary = "A Ruby implementation of the Pipeline Pattern."
  spec.description = "A Ruby implementation of the Pipeline Pattern."
  spec.homepage = "https://github.com/mjfreelancing/AllOverIt-Ruby"
  spec.license = "MIT"
  spec.required_ruby_version = ">= 3.0.0"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/mjfreelancing/AllOverIt-Ruby/alloverit-patterns-pipeline"
  spec.metadata["changelog_uri"] = "https://github.com/mjfreelancing/AllOverIt-Ruby/alloverit-patterns-pipeline/CHANGELOG.md"

  spec.add_dependency "alloverit-utils", "~> 1.0"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ test/ spec/ features/ .git appveyor Gemfile demos/])
    end
  end
  spec.bindir = "exe"
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"

  # For more information and examples about making a new gem, check out our
  # guide at: https://bundler.io/guides/creating_gem.html
end
