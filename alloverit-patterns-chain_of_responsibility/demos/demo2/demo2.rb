# frozen_string_literal: true

require "alloverit/patterns/chain_of_responsibility"

require_relative "support_request"
require_relative "handlers/low_severity_handler"
require_relative "handlers/medium_severity_handler"
require_relative "handlers/high_severity_handler"

ChainOfResponsibility = AllOverIt::Patterns::ChainOfResponsibility

# This demo manually chains a number of handlers
module Demo2
  requests = [
    SupportRequest.new(:low, "This is a minor issue."),
    SupportRequest.new(:low_medium, "This needs to be triaged."),
    SupportRequest.new(:medium, "This needs attention."),
    SupportRequest.new(:high, "Critical failure!"),
    SupportRequest.new(:unknown, "This should not be handled.")
  ]

  # Need to have a reference to the first handler in the chain (to send all requests to)
  first_handler = HighSeverityHandler.new

  first_handler.next_handler(MediumSeverityHandler.new)
               .next_handler do |request|
                 # Return a result if handled, otherwise nil
                 request.severity == :low_medium ? "Low-Medium Severity: #{request.message}" : nil
               end
               .next_handler(LowSeverityHandler.new)

  requests.each do |request|
    response = first_handler.handle(request)
    puts response || "No handler found for severity: #{request.severity}"
  end
end
