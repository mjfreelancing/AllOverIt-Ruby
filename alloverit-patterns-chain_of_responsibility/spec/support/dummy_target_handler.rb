# frozen_string_literal: true

require_relative "../../lib/alloverit/patterns/chain_of_responsibility/chain_of_responsibility_handler"

class DummyTargetHandler < AllOverIt::Patterns::ChainOfResponsibility::ChainOfResponsibilityHandler
  def initialize(target_value)
    super()

    @target_value = target_value
  end

  def handle(request)
    return request if request == @target_value

    super
  end
end
