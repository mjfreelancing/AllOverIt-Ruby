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

# An alternative syntax
[1, 2, 3, 4, -2].select(&spec.method(:satisfied_by?)) # => [2, 4]
```

## Specification vs CompositeSpecification: When and Why

The library provides two ways to define your own specifications: by including the `Specification` module or by inheriting from `CompositeSpecification`. Understanding the difference is important for writing maintainable and composable business rules.

### Including `Specification`

- **Purpose:** Use this for simple, atomic specifications that represent a single rule.
- **Behavior:** You must implement the `satisfied_by?` and `to_s` methods yourself.
- **Combinators:** The combinator methods (`and`, `or`, `not`, etc.) are available because they are defined in the module. However, using them on a class that only includes `Specification` will return composite specification objects that expect their operands to behave like composites.
- **Limitation:** If your concrete specification only includes `Specification` (and does not inherit from `CompositeSpecification`), it may not be recognized as a composite by type checks or by code that expects a composite. This can lead to subtle bugs or incompatibilities, especially if you want to further compose the result.

### Inheriting from `CompositeSpecification`

- **Purpose:** Use this when you want your specification to be composable with others using `.and`, `.or`, `.not`, etc.
- **Behavior:** You still implement `satisfied_by?` and `to_s`, but you also inherit all combinator logic and are fully compatible with the library's composition features.
- **Composability:** Only specifications that inherit from `CompositeSpecification` are guaranteed to be safely and robustly composable. This is the idiomatic and recommended approach for any specification you want to combine with others.

### Why Can't Concretes Based on `Specification` Be Composed?

While the combinator methods are technically available to any class including `Specification`, the resulting composite objects expect their operands to be compatible with the composite pattern (i.e., to inherit from `CompositeSpecification`). If you compose specifications that do not inherit from `CompositeSpecification`, you may encounter issues with type checks, further composition, or library features that rely on the composite structure.

**In summary:**

- Use `include Specification` for simple, standalone rules that won't be composed.
- Use `CompositeSpecification` as a base class for any specification you want to combine with others.
- For maximum flexibility and compatibility, prefer inheriting from `CompositeSpecification` for all your custom specifications.

```ruby
# Not composable (not recommended for combining)
class IsEven
  include AllOverIt::Patterns::Specification
  def satisfied_by?(candidate)
    candidate.even?
  end
end

# Composable (recommended)
class IsEven < AllOverIt::Patterns::Specification::CompositeSpecification
  def satisfied_by?(candidate)
    candidate.even?
  end
end
```

## Advanced Usage and Combinators

You can combine specifications using `.and`, `.or`, and `.not`, and chain them to express complex logic:

```ruby
spec = IsEven.new.or(IsPositive.new.not)
[1, 2, 3, 4, -2, -3].select { |n| spec.satisfied_by?(n) } # => [2, 4, -2, -3]

# Chaining
spec = IsEven.new.and(IsPositive.new).or(IsEven.new.not)

# Negation
spec = IsEven.new.not
```

### Dynamic Specification Building

You can build specifications dynamically, for example, based on user input:

```ruby
spec = AllOverIt::Patterns::Specification.always_true
spec = spec.and(IsEven.new) if params[:even]
spec = spec.and(IsPositive.new) if params[:positive]
```

### Always True / Always False Specifications

The base library provides `AlwaysTrueSpecification` and `AlwaysFalseSpecification` specifications for convenience:

```ruby
spec = AllOverIt::Patterns::Specification.always_true # A singleton instance
spec = spec.and(IsEven.new) # Start with a match-all, then add conditions

spec = AllOverIt::Patterns::Specification.always_false # A singleton instance
spec = spec.or(IsPositive.new) # Start with match-none, then add conditions
```

## API Reference

- `and(other_spec)` – Combine with another specification (logical AND)
- `or(other_spec)` – Combine with another specification (logical OR)
- `not` – Negate the specification
- `satisfied_by?(candidate)` – Returns true if the candidate satisfies the specification
- `to_s` – String representation of the specification
- `.always_true` – Returns a specification that always matches
- `.always_false` – Returns a specification that never matches

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

```bash
rake -T
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

## Extending to ActiveRecord

For database-backed models and SQL composition, see [AllOverIt::Patterns::SpecificationActiveRecord](../alloverit-patterns-specification_active_record/README.md).
