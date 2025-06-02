# AllOverIt::Patterns::SpecificationActiveRecord

This gem extends the [AllOverIt::Patterns::Specification](../alloverit-patterns-specification/README.md) pattern to work seamlessly with ActiveRecord models. It allows you to compose business rules as specifications and apply them directly to database queries, as well as in-memory objects. This package builds on the core Specification gem, adding robust Arel-based SQL composition, ActiveRecord integration, and a suite of helpers for advanced, composable, and database-agnostic querying.

## Features

- Compose complex query logic using specifications, with full support for AND, OR, NOT, and custom combinators
- Use the same specification for both ActiveRecord queries (SQL) and in-memory filtering (Ruby)
- Integrates with ActiveRecord via a `scoped_to` method for easy application of specifications to queries
- Provides a rich set of ArelHelpers for safe, portable, and expressive SQL predicate construction (e.g., case-insensitive LIKE, regex, modulo, etc.)
- Supports chaining and composition of specifications for highly readable and maintainable business logic
- Fully compatible with the non-ActiveRecord [AllOverIt::Patterns::Specification](../alloverit-patterns-specification/README.md) gem. Use the same patterns for both in-memory and database-backed models

## How It Works

- **Specifications** encapsulate business rules as objects. You can combine them using `.and`, `.or`, `.not`, and custom logic.
- **ActiveRecord Integration**: Each specification can provide a `to_arel(table)` method, which returns an Arel predicate for SQL queries. The gem's `scoped_to` method applies these to ActiveRecord relations.
- **ArelHelpers**: Use the provided helpers to build robust, DB-agnostic predicates (e.g., case-insensitive equality, LIKE, IN, BETWEEN, regex, etc.)
- **In-memory Filtering**: The same specification can be used to filter Ruby objects with `satisfied_by?`.

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

Suppose you have a `Chilli` model and want to filter by color and origin using specifications. With the available ArelHelpers, you can build your `to_arel` using Arel for robust, DB-agnostic SQL:

```ruby
class HasColor < AllOverIt::Patterns::SpecificationActiveRecord::Specification
  def initialize(color)
    @color = color
  end

  def to_arel(table)
    AllOverIt::Patterns::SpecificationActiveRecord::ArelHelpers.equals_insensitive(table[:colors], @color)
  end

  def satisfied_by?(chilli)
    chilli.color_list.map(&:downcase).include?(@color.downcase)
  end
end
```

```ruby
class HasOrigin < AllOverIt::Patterns::SpecificationActiveRecord::Specification
  def initialize(origin)
    @origin = origin
  end

  def to_arel(table)
    AllOverIt::Patterns::SpecificationActiveRecord::ArelHelpers.equals_insensitive(table[:origin], @origin)
  end

  def satisfied_by?(chilli)
    chilli.origin.downcase == @origin.downcase
  end
end
```

```ruby
# Compose specifications
spec = HasColor.new('red').and(HasOrigin.new('mexico'))

# ActiveRecord query (assuming .scoped_to uses .to_arel internally)
results = Chilli.scoped_to(spec)

# In-memory filtering
Chilli.all.select { |chilli| spec.satisfied_by?(chilli) }
```

### Chaining and Composing Specifications

Specifications can be chained and combined to express complex business logic in a highly readable way:

```ruby
# Find chillis that are red, from Mexico, and are mild OR have a certain shape
spec = HasColor.new('red')
         .and(HasOrigin.new('mexico'))
         .and(HasHeatLevel.new('mild').or(HasShape.new('round')))

results = Chilli.scoped_to(spec)

# Negate a specification
not_mexican = HasOrigin.new('mexico').not

# Combine with other logic
spec = HasColor.new('green').and(not_mexican)

# Use with in-memory objects
Chilli.all.select { |chilli| spec.satisfied_by?(chilli) }
```

You can also build specifications dynamically:

```ruby
spec = AllOverIt::Patterns::SpecificationActiveRecord::Specification.always_true
spec = spec.and(HasColor.new('yellow')) if params[:color]
spec = spec.and(HasOrigin.new('peru')) if params[:origin]
results = Chilli.scoped_to(spec)
```

### Dynamic Specifications Example

You can use the built-in `AlwaysTrueSpecificationActiveRecord` and `AlwaysFalseSpecificationActiveRecord` specifications to simplify dynamic query building:

```ruby
# Start with a specification that matches everything - returns a new AlwaysTrueSpecificationActiveRecord
spec = AllOverIt::Patterns::SpecificationActiveRecord::Specification.always_true

# Dynamically add filters
spec = spec.and(HasColor.new(params[:color])) if params[:color].present?
spec = spec.and(HasOrigin.new(params[:origin])) if params[:origin].present?

# Or start with a specification that matches nothing - returns a new AlwaysFalseSpecificationActiveRecord
spec = AllOverIt::Patterns::SpecificationActiveRecord::Specification.always_false

# Compose as needed
spec = spec.or(HasColor.new('red'))

# Use with ActiveRecord
results = Chilli.scoped_to(spec)

# Use with in-memory objects
Chilli.all.select { |chilli| spec.satisfied_by?(chilli) }
```

## ArelHelpers Overview

ArelHelpers provides a suite of methods for building robust, portable SQL predicates. Here are some examples:

- `like(column, value)`
  ```ruby
  ArelHelpers.like(table[:name], "%foo%") # => table.name LIKE '%foo%'
  ```
- `like_insensitive(column, value)`
  ```ruby
  ArelHelpers.like_insensitive(table[:name], "%foo%") # => LOWER(table.name) LIKE '%foo%'
  ```
- `not_like(column, value)`
  ```ruby
  ArelHelpers.not_like(table[:name], "%foo%") # => table.name NOT LIKE '%foo%'
  ```
- `not_like_insensitive(column, value)`
  ```ruby
  ArelHelpers.not_like_insensitive(table[:name], "%foo%") # => LOWER(table.name) NOT LIKE '%foo%'
  ```
- `equals(column, value)`
  ```ruby
  ArelHelpers.equals(table[:id], 1) # => table.id = 1
  ```
- `equals_insensitive(column, value)`
  ```ruby
  ArelHelpers.equals_insensitive(table[:name], "FOO") # => LOWER(table.name) = 'foo'
  ```
- `not_equal(column, value)`
  ```ruby
  ArelHelpers.not_equal(table[:id], 1) # => table.id != 1
  ```
- `not_equal_insensitive(column, value)`
  ```ruby
  ArelHelpers.not_equal_insensitive(table[:name], "FOO") # => LOWER(table.name) != 'foo'
  ```
- `in(column, values)`
  ```ruby
  ArelHelpers.in(table[:id], [1,2,3]) # => table.id IN (1,2,3)
  ```
- `not_in(column, values)`
  ```ruby
  ArelHelpers.not_in(table[:id], [1,2,3]) # => table.id NOT IN (1,2,3)
  ```
- `between(column, min, max)`
  ```ruby
  ArelHelpers.between(table[:id], 1, 10) # => table.id BETWEEN 1 AND 10
  ```
- `is_null(column)`
  ```ruby
  ArelHelpers.is_null(table[:deleted_at]) # => table.deleted_at IS NULL
  ```
- `is_not_null(column)`
  ```ruby
  ArelHelpers.is_not_null(table[:deleted_at]) # => table.deleted_at IS NOT NULL
  ```
- `modulo(column, value)`
  ```ruby
  ArelHelpers.modulo(table[:id], 2) # => MOD(table.id, 2)
  ```
- `regex(column, pattern)`
  ```ruby
  ArelHelpers.regex(table[:name], '^foo') # => table.name ~ '^foo' (if supported)
  ```
- `not_regex(column, pattern)`
  ```ruby
  ArelHelpers.not_regex(table[:name], '^foo') # => table.name !~ '^foo' (if supported)
  ```

See the [ArelHelpers documentation](lib/alloverit/patterns/specification_active_record/arel_helpers.rb) for full details and usage examples.

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

```bash
rake -T
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
