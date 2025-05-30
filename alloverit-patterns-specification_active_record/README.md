# AllOverIt::Patterns::SpecificationActiveRecord

This gem extends the Specification pattern to work seamlessly with ActiveRecord models. It allows you to compose business rules as specifications and apply them directly to database queries, as well as in-memory objects.

## Features

- Compose complex query logic using specifications
- Use the same specification for both ActiveRecord queries and in-memory filtering
- Integrates with ActiveRecord via a `scoped_to` method

## Setup & Installation

To set up all dependencies for every gem in this repository, run the following from the root:

```bash
ruby setup_all.rb
```

Alternatively, you can set up just this gem by running:

```bash
cd alloverit-patterns-specification_active_record
bin/setup
```

Add the gem to your application's Gemfile:

```bash
bundle add alloverit-patterns-specification_active_record
```

Or install it manually:

```bash
gem install alloverit-patterns-specification_active_record
```

## Usage Example

Suppose you have a `Chilli` model and want to filter by color and origin using specifications:

```ruby
class HasColor < AllOverIt::Patterns::SpecificationActiveRecord::Specification
  def initialize(color)
    @color = color.downcase
  end
  def to_scope
    ->(rel) { rel.where('LOWER(colors) LIKE ?', "%#{@color}%") }
  end
  def satisfied_by?(chilli)
    chilli.colors.downcase.include?(@color)
  end
end

class HasOrigin < AllOverIt::Patterns::SpecificationActiveRecord::Specification
  def initialize(origin)
    @origin = origin.downcase
  end
  def to_scope
    ->(rel) { rel.where('LOWER(origin) = ?', @origin) }
  end
  def satisfied_by?(chilli)
    chilli.origin.downcase == @origin
  end
end

# Compose specifications
spec = HasColor.new('red').and(HasOrigin.new('mexico'))

# ActiveRecord query
results = Chilli.scoped_to(spec)

# In-memory filtering
Chilli.all.select { |chilli| spec.satisfied_by?(chilli) }
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
cd alloverit-patterns-specification_active_record
bundle exec rake spec
```

To run all tests for every gem in the repository:

```bash
ruby run_all_tests.rb
```

## Coverage Reports

After running tests, open the following file in your browser to view the coverage report for this gem:

```
alloverit-patterns-specification_active_record/coverage/index.html
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
