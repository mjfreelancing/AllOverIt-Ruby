# Chain of Responsibility Pattern: Usage with AllOverIt

## What is the Chain of Responsibility Pattern?

The Chain of Responsibility (CoR) is a behavioral design pattern that allows a request to pass through a chain of handlers. Each handler decides either to process the request or to pass it to the next handler in the chain. This decouples the sender of a request from its receivers, giving more flexibility in assigning responsibilities to objects.

**Key Benefits:**

- Decouples sender and receiver
- Promotes single responsibility and open/closed principles
- Flexible and dynamic handler composition

## How AllOverIt Implements Chain of Responsibility

This gem provides a robust, extensible implementation of the CoR pattern. It allows you to:

- Compose handlers using classes or blocks
- Dynamically build chains at runtime
- Return custom results from handlers
- Cleanly separate concerns

### Core Concepts

- **Handler Base Class:** Inherit from `AllOverIt::Patterns::ChainOfResponsibility::ChainOfResponsibilityHandler` to create your own handlers.
- **Composing Chains:** Use `.compose` to link handlers together.
- **Block Handlers:** Insert inline logic using blocks.

## Example: Support Request Handling

Suppose you want to process support requests of varying severity. Each handler will process a specific severity, or pass the request along.

### 1. Define the Request Object

```ruby
class SupportRequest
  attr_reader :severity, :message
  def initialize(severity, message)
    @severity = severity
    @message = message
  end
end
```

### 2. Create Handlers

Each handler inherits from `ChainOfResponsibilityHandler` and implements `handle`:

```ruby
class LowSeverityHandler < ChainOfResponsibilityHandler
  def handle(request)
    return "Low Severity: #{request.message}" if request.severity == :low
    super(request)
  end
end

class MediumSeverityHandler < ChainOfResponsibilityHandler
  def handle(request)
    return "Medium Severity: #{request.message}" if request.severity == :medium
    super(request)
  end
end

class HighSeverityHandler < ChainOfResponsibilityHandler
  def handle(request)
    return "High Severity: #{request.message}" if request.severity == :high
    super(request)
  end
end
```

### 3. Compose the Chain

You can compose handlers using the provided `.compose` method:

```ruby
first_handler = AllOverIt::Patterns::ChainOfResponsibility.compose(
  HighSeverityHandler,
  LowSeverityHandler,
  MediumSeverityHandler
)
```

### 4. Process Requests

```ruby
# Requests to be processed
requests = [
  SupportRequest.new(:low, "This is a minor issue."),
  SupportRequest.new(:medium, "This needs attention."),
  SupportRequest.new(:high, "Critical failure!"),
  SupportRequest.new(:unknown, "This should not be handled.")
]

# Pass each request to the chain for processing
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

## Summary

The AllOverIt Chain of Responsibility gem provides a flexible, extensible, and idiomatic Ruby implementation of the pattern. It is suitable for a wide range of scenarios where decoupled, sequential request processing is needed.

For more details, see the demos in the `demos/` directory and the gem's tests for advanced usage patterns.
