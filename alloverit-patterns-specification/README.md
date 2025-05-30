# AllOverIt::Patterns::Specification

The Specification pattern is a design pattern used to encapsulate business logic and validation rules into reusable and composable components. It separates the logic for decision-making from the entities or classes that use it, enabling flexible and maintainable development of complex ad-hoc search queries and validation rules.

## Features

- Compose specifications using boolean logic (`and`, `or`, `not`, etc.)
- Reuse and combine business rules
- Evaluate specifications in memory or translate to queries (see ActiveRecord extension)

## Setup & Installation

To set up all dependencies for every gem in this repository, run the following from the root:

```bash
ruby setup_all.rb
```

Alternatively, you can set up just this gem by running:

```bash
cd alloverit-patterns-specification
bin/setup
```

Add the gem to your application's Gemfile:

```bash
bundle add alloverit-patterns-specification
```

Or install it manually:

```bash
gem install alloverit-patterns-specification
```

## Usage Example

Suppose you want to filter objects based on multiple criteria:

```ruby
class IsEven < AllOverIt::Patterns::Specification
  def satisfied_by?(candidate)
    candidate.even?
  end
end

class IsPositive < AllOverIt::Patterns::Specification
  def satisfied_by?(candidate)
    candidate > 0
  end
end

spec = IsEven.new.and(IsPositive.new)

[1, 2, 3, 4, -2].select { |n| spec.satisfied_by?(n) } # => [2, 4]
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
cd alloverit-patterns-specification
bundle exec rake spec
```

To run all tests for every gem in the repository:

```bash
ruby run_all_tests.rb
```

## Coverage Reports

After running tests, open the following file in your browser to view the coverage report for this gem:

```
alloverit-patterns-specification/coverage/index.html
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
