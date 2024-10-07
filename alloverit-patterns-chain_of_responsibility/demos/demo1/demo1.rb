# frozen_string_literal: true

require "alloverit/patterns/chain_of_responsibility"

require_relative "support_request"
require_relative "handlers/low_severity_handler"
require_relative "handlers/medium_severity_handler"
require_relative "handlers/high_severity_handler"

ChainOfResponsibility = AllOverIt::Patterns::ChainOfResponsibility

# This demo #composes pre-built handlers - it's the most intuitive approach since #compose returns the first handler.
module Demo1
  requests = [
    SupportRequest.new(:low, "This is a minor issue."),
    SupportRequest.new(:medium, "This needs attention."),
    SupportRequest.new(:high, "Critical failure!"),
    SupportRequest.new(:unknown, "This should not be handled.")
  ]

  first_handler = ChainOfResponsibility.compose(HighSeverityHandler, LowSeverityHandler, MediumSeverityHandler)

  requests.each do |request|
    response = first_handler.handle(request)
    puts response || "No handler found for severity: #{request.severity}"
  end
end
