# frozen_string_literal: true

require_relative "../../lib/alloverit/patterns/chain_of_responsibility"
require_relative "support_request"
require_relative "handlers/low_severity_handler"
require_relative "handlers/medium_severity_handler"
require_relative "handlers/high_severity_handler"

ChainOfResponsibility = AllOverIt::Patterns::ChainOfResponsibility

module Demo1
  requests = [
    SupportRequest.new(:low, "This is a minor issue."),
    SupportRequest.new(:medium, "This needs attention."),
    SupportRequest.new(:high, "Critical failure!"),
    SupportRequest.new(:unknown, "This should not be handled.")
  ]

  # Handlers can be new'd up and chained like this:
  #
  # handler1 = HighSeverityHandler.new
  # handler2 = MediumSeverityHandler.new
  # handler3 = LowSeverityHandler.new
  # handler1.next_handler(handler2).next_handler(handler3)

  # Or they can be composed in a single call. The array can be class types or instances (as shown).
  handler1 = ChainOfResponsibility.compose(HighSeverityHandler, LowSeverityHandler, MediumSeverityHandler)

  requests.each do |request|
    response = handler1.handle(request)
    puts response || "No handler found for severity: #{request.severity}"
  end

end
