# frozen_string_literal: true

class Result
  attr_reader :errors

  def initialize
    @errors = []
  end

  def okay?
    errors.empty?
  end

  def <<(message)
    @errors << message if message
  end
end
