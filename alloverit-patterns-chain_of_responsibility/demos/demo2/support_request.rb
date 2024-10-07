# frozen_string_literal: true

module Demo2
  class SupportRequest
    attr_reader :severity, :message

    def initialize(severity, message)
      @severity = severity
      @message = message
    end
  end
end
