# AllOverIt Ruby Gems

This mono-repository contains a collection of Ruby gems that provide implementations of common design patterns and utility functions. These gems are designed to work together to help you build robust, maintainable Ruby applications.

## Overview

The AllOverIt Ruby gem collection focuses on providing clean, well-tested implementations of proven design patterns and utilities. Each gem is independently usable but designed to work harmoniously with the others in the collection.

## Getting Started

### Repository Setup

To set up all dependencies for every gem in this repository:

```bash
ruby setup_all.rb
```

This will run `bin/setup` for each gem, installing all required dependencies.

### Running All Tests

To run the complete test suite across all gems:

```bash
ruby run_all_tests.rb
```

This will execute the test suite for each gem and provide a summary of results.

## Ruby Gems

### [alloverit-patterns-chain_of_responsibility](alloverit-patterns-chain_of_responsibility/README.md)
Provides a robust, extensible implementation of the Chain of Responsibility design pattern. Allows requests to pass through a chain of handlers, where each handler can either process the request or pass it to the next handler.

### [alloverit-patterns-pipeline](alloverit-patterns-pipeline/README.md)
Provides an implementation of the Pipeline design pattern. Compose a sequence of processing steps (stages) where the output of one stage becomes the input to the next, perfect for building flexible data processing flows.

### [alloverit-patterns-specification](alloverit-patterns-specification/README.md)
Provides an implementation of the Specification design pattern. Encapsulate business logic and validation rules into reusable and composable components, enabling flexible and maintainable development of complex queries and validation rules.

### [alloverit-patterns-specification_active_record](alloverit-patterns-specification_active_record/README.md)
Extends the Specification pattern to work seamlessly with ActiveRecord models. Apply the same specification for both ActiveRecord queries (SQL) and in-memory filtering (Ruby), with rich Arel-based SQL composition helpers.

### [alloverit-profiler](alloverit-profiler/README.md)
A flexible and lightweight profiling gem for tracking the execution of code blocks, including nested operations and custom breadcrumbs. Helps analyze performance and execution flow in Ruby applications.

### [alloverit-utils](alloverit-utils/README.md)
Provides general purpose utilities that support other AllOverIt gems. Contains utility methods for instance checking, module/class inclusion, and argument validation.

## Individual Gem Installation

Each gem can be installed independently:

```bash
gem install alloverit-patterns-chain_of_responsibility
gem install alloverit-patterns-pipeline
gem install alloverit-patterns-specification
gem install alloverit-patterns-specification_active_record
gem install alloverit-profiler
gem install alloverit-utils
```

Or add to your Gemfile:

```ruby
gem 'alloverit-patterns-chain_of_responsibility'
gem 'alloverit-patterns-pipeline'
gem 'alloverit-patterns-specification'
gem 'alloverit-patterns-specification_active_record'
gem 'alloverit-profiler'
gem 'alloverit-utils'
```

## Development

### Running Tests for Individual Gems

Each gem has its own test suite that can be run independently:

```bash
cd <gem-directory>
bundle exec rake spec
```

### Code Quality

All gems use RuboCop for code linting and style checks:

```bash
cd <gem-directory>
bundle exec rake rubocop
```

### Coverage Reports

After running tests, coverage reports are available for each gem:
- Individual gem: `<gem-directory>/coverage/index.html`
- Combined report: `coverage/combined/index.html`

You can also use the `rake coverage` task within any gem directory to automatically open the coverage report in your default browser (macOS/Linux) or display the path if not supported:

```bash
cd <gem-directory>
bundle exec rake coverage
```

## License

All gems are available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
