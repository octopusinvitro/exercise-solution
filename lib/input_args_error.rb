# frozen_string_literal: true

class InputArgsError < StandardError
  def initialize(message)
    super(message)
  end
end
