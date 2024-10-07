# frozen_string_literal: true

require "alloverit/patterns/chain_of_responsibility/chain_of_responsibility_handler"

module Demo2
  class MediumSeverityHandler < AllOverIt::Patterns::ChainOfResponsibility::ChainOfResponsibilityHandler
    def handle(request)
      return "Medium Severity: #{request.message}" if request.severity == :medium

      # Move onto the next handler if not handled here
      super(request)
    end
  end
end
