# frozen_string_literal: true

require_relative "../../../lib/alloverit/patterns/chain_of_responsibility/chain_of_responsibility_handler"

module Demo1
  class LowSeverityHandler < AllOverIt::Patterns::ChainOfResponsibility::ChainOfResponsibilityHandler
    def handle(request)
      return "Low Severity: #{request.message}" if request.severity == :low

      # Move onto the next handler if not handled here
      super(request)
    end
  end
end
