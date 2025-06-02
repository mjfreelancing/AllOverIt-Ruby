# AllOverIt::Utils

This general purpose utility gem primarily exists to support other **AllOverIt** gems. Take a look, you might find something useful for your own projects.

You can find the source at `lib/alloverit/utils`.

## Features

- Utility methods for instance checking, module/class inclusion, and argument validation
- Used as a dependency by other AllOverIt gems

## Setup & Installation

To set up all dependencies for every gem in this repository, run the following from the root:

```bash
ruby setup_all.rb
```

Alternatively, you can set up just this gem by running:

```bash
cd alloverit-utils
bin/setup
```

Add the gem to your application's Gemfile:

```bash
bundle add alloverit-utils
```

Or install it manually:

```bash
gem install alloverit-utils
```

## Usage

### AllOverIt::Utils module

#### .as_instance

Checks whether the argument is a class or an instance. If a class is provided, it returns a default initialized instance of the class. If an instance is provided, it returns the instance as is.

```ruby
class SomeClass; end

# Will create an instance of SomeClass and return it
instance1 = AllOverIt::Utils.as_instance(SomeClass)

# instance2 will be the same as instance1
instance2 = AllOverIt::Utils.as_instance(instance1)
```

#### .ensure_instance_includes

Checks that an instance variable includes a specified module. The instance is returned if its ancestor chain includes the module, otherwise an ArgumentError is raised.

```ruby
module SomeModule; end
class SomeClass; end
class AnotherClass; include SomeModule; end

instance1 = SomeClass.new
instance2 = AnotherClass.new

# Will raise an ArgumentError
instance3 = AllOverIt::Utils.ensure_instance_includes(instance1, SomeModule)

# instance4 will be the same as instance2
instance4 = AllOverIt::Utils.ensure_instance_includes(instance2, SomeModule)
```

#### .ensure_instance_is_a

Checks that an instance variable inherits a specified class. The instance is returned if it inherits the specified class, otherwise an ArgumentError is raised.

```ruby
class SomeClass; end
class AnotherClass < SomeClass; end

instance1 = SomeClass.new
instance2 = AnotherClass.new

# Will raise an ArgumentError
instance3 = AllOverIt::Utils.ensure_instance_is_a(instance1, SomeOtherClass)

# instance4 will be the same as instance2
instance4 = AllOverIt::Utils.ensure_instance_is_a(instance2, SomeClass)
```

### AllOverIt::Utils::Check module

#### .not_nil

Use this method to perform pre-condition checks on one or more method arguments to assert they are not nil.

```ruby
def do_something(arg1, arg2, arg3)
  AllOverIt::Utils::Check.not_nil(arg1: arg1, arg2: arg2, arg3: arg3)
  # ... remainder of the code here
end
```

If any argument is `nil` then an `ArgumentError` will be raised for that argument. The name of the symbol will be reported in the error.

## Rake Tasks

The following Rake tasks are available for development and testing:

- `rake spec` – Run the test suite using RSpec.
- `rake rubocop` – Run RuboCop for code linting and style checks.
- `rake clean` – Remove old gem files from the `pkg/` directory.
- `rake build` – Clean, then run tests before building/installing the gem (used by `bundle exec rake install`).
- `rake` (default) – Runs both `spec` and `rubocop` tasks.
- `rake coverage` – Open the coverage report for this gem in your default browser (macOS/Linux) or print the path if not supported.

You can list all available tasks by running:

```bash
rake -T
```

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
