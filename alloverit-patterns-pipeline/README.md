# AllOverIt::Patterns::Pipeline

This gem provides an implementation of the Pipeline design pattern for Ruby. The Pipeline pattern allows you to compose a sequence of processing steps (stages), where the output of one stage is the input to the next. This is useful for building flexible, reusable, and testable data processing flows.

## Features

- Compose pipelines from modular stages (as classes or blocks)
- Dynamically build and modify pipelines at runtime
- Clean separation of processing logic

## Setup & Installation

To set up all dependencies for every gem in this repository, run the following from the root:

```bash
ruby setup_all.rb
```

Alternatively, you can set up just this gem by running:

```bash
cd alloverit-patterns-pipeline
bin/setup
```

Add the gem to your application's Gemfile:

```bash
bundle add alloverit-patterns-pipeline
```

Or install it manually:

```bash
gem install alloverit-patterns-pipeline
```

## Usage Example

Suppose you want to process a string through several transformation steps:

```ruby
class UpcaseStage
  def call(input)
    input.upcase
  end
end

class ReverseStage
  def call(input)
    input.reverse
  end
end

pipeline = AllOverIt::Patterns::Pipeline.new
pipeline.add_stage(UpcaseStage.new)
pipeline.add_stage(ReverseStage.new)

result = pipeline.execute('hello')
puts result # => "OLLEH"
```

You can also use blocks as stages:

```ruby
pipeline.add_stage(->(input) { "#{input}!" })
```

## Demos

Demo applications are located in the `demos/` directory. To run a demo:

```bash
cd demos/demo1
ruby demo1.rb
```

or

```bash
cd demos/demo2
ruby demo2.rb
```

## Running Tests

To run tests for this gem only:

```bash
cd alloverit-patterns-pipeline
bundle exec rake spec
```

To run all tests for every gem in the repository:

```bash
ruby run_all_tests.rb
```

## Coverage Reports

After running tests, open the following file in your browser to view the coverage report for this gem:

```
alloverit-patterns-pipeline/coverage/index.html
```

For a combined coverage report across all gems, see:

```
coverage/combined/index.html
```

## Rake Tasks

The following Rake tasks are available for development and testing:

- `rake spec` – Run the test suite using RSpec.
- `rake rubocop` – Run RuboCop for code linting and style checks.
- `rake clean` – Remove old gem files from the `pkg/` directory.
- `rake build` – Clean, then run tests before building/installing the gem (used by `bundle exec rake install`).
- `rake demo1` – Run the demo application in `demos/demo1/demo1.rb`.
- `rake demo2` – Run the demo application in `demos/demo2/demo2.rb`.
- `rake coverage` – Open the coverage report for this gem in your default browser (macOS/Linux) or print the path if not supported.
- `rake` (default) – Runs both `spec` and `rubocop` tasks.

You can list all available tasks by running:

```zsh
rake -T
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
