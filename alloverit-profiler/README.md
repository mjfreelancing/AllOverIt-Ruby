# AllOverIt::Profiler

AllOverIt::Profiler is a flexible and lightweight Ruby gem for profiling and tracking the execution of code blocks, including nested operations and custom breadcrumbs. It is designed to help you analyze performance and execution flow in your Ruby applications.

## Features

- Profile code blocks with custom tags
- Track nested operations and execution hierarchy
- Add breadcrumbs (custom messages) during profiling
- Retrieve and analyze profiling results programmatically

## Setup & Installation

To set up all dependencies for every gem in this repository, run the following from the root:

```bash
ruby setup_all.rb
```

Alternatively, you can set up just this gem by running:

```bash
cd alloverit-profiler
bin/setup
```

Add the gem to your application's Gemfile:

```bash
bundle add alloverit-profiler
```

Or install it manually:

```bash
gem install alloverit-profiler
```

## Usage Example

Profile a block of code and its nested operations:

```ruby
require 'alloverit/profiler'

AllOverIt::Profiler.start do
  AllOverIt::Profiler.track('outer') do
    sleep(0.1)
    AllOverIt::Profiler.track('inner') do
      sleep(0.2)
      AllOverIt::Profiler.breadcrumb(nil, 'Reached inner block')
    end
  end
end
```

You can add breadcrumbs at any point to mark significant events:

```ruby
AllOverIt::Profiler.breadcrumb(nil, 'Custom event message')
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
cd alloverit-profiler
bundle exec rake spec
```

To run all tests for every gem in the repository:

```bash
ruby run_all_tests.rb
```

## Coverage Reports

After running tests, open the following file in your browser to view the coverage report for this gem:

```
alloverit-profiler/coverage/index.html
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
