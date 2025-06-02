# AllOverIt::Patterns::ChainOfResponsibility

This gem provides a robust, extensible implementation of the Chain of Responsibility design pattern for Ruby. The Chain of Responsibility (CoR) pattern allows a request to pass through a chain of handlers, where each handler can either process the request or pass it to the next handler. This decouples the sender of a request from its receivers, promoting flexibility and clean separation of concerns.

## Features

- Compose handler chains using classes or blocks
- Dynamically build chains at runtime
- Return custom results from handlers
- Cleanly separate concerns and responsibilities

## Setup & Installation

To set up all dependencies for every gem in this repository, run the following from the root:

```bash
ruby setup_all.rb
```

Alternatively, you can set up just this gem by running:

```bash
cd alloverit-patterns-chain_of_responsibility
bin/setup
```

Add the gem to your application's Gemfile:

```bash
bundle add alloverit-patterns-chain_of_responsibility
```

Or install it manually:

```bash
gem install alloverit-patterns-chain_of_responsibility
```

## Usage Example

Suppose you want to process support requests of varying severity. Each handler will process a specific severity, or pass the request along.

```ruby
class SupportRequest
  attr_reader :severity, :message
  def initialize(severity, message)
    @severity = severity
    @message = message
  end
end

class LowSeverityHandler < AllOverIt::Patterns::ChainOfResponsibility::ChainOfResponsibilityHandler
  def handle(request)
    return "Low Severity: #{request.message}" if request.severity == :low
    super(request)
  end
end

class MediumSeverityHandler < AllOverIt::Patterns::ChainOfResponsibility::ChainOfResponsibilityHandler
  def handle(request)
    return "Medium Severity: #{request.message}" if request.severity == :medium
    super(request)
  end
end

class HighSeverityHandler < AllOverIt::Patterns::ChainOfResponsibility::ChainOfResponsibilityHandler
  def handle(request)
    return "High Severity: #{request.message}" if request.severity == :high
    super(request)
  end
end

# Compose the chain
first_handler = AllOverIt::Patterns::ChainOfResponsibility.compose(
  HighSeverityHandler,
  LowSeverityHandler,
  MediumSeverityHandler
)

# Process requests
requests = [
  SupportRequest.new(:low, "This is a minor issue."),
  SupportRequest.new(:medium, "This needs attention."),
  SupportRequest.new(:high, "Critical failure!"),
  SupportRequest.new(:unknown, "This should not be handled.")
]

requests.each do |request|
  response = first_handler.handle(request)
  puts response || "No handler found for severity: #{request.severity}"
end
```

**Output:**

```
Low Severity: This is a minor issue.
Medium Severity: This needs attention.
High Severity: Critical failure!
No handler found for severity: unknown
```

## Advanced Usage: Manual Chaining and Block Handlers

You can manually chain handlers and even use blocks for custom logic:

```ruby
first_handler = HighSeverityHandler.new
first_handler.next_handler(MediumSeverityHandler.new)
             .next_handler do |request|
               request.severity == :low_medium ? "Low-Medium Severity: #{request.message}" : nil
             end
             .next_handler(LowSeverityHandler.new)
```

## Handler API

- `next_handler(handler = nil, &block)`: Sets the next handler. Accepts either a handler instance or a block.
- `handle(request)`: Attempts to handle the request, or passes it to the next handler.

## Testing and Extensibility

- Handlers can be easily tested in isolation.
- You can mix classes and blocks in any order.
- Return any value from a handler to indicate the request was handled.

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
cd alloverit-patterns-chain_of_responsibility
bundle exec rake spec
```

To run all tests for every gem in the repository:

```zsh
ruby run_all_tests.rb
```

## Coverage Reports

After running tests, open the following file in your browser to view the coverage report for this gem:

```
alloverit-patterns-chain_of_responsibility/coverage/index.html
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
