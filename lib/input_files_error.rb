# frozen_string_literal: true

class InputFilesError < StandardError
  def initialize(message)
    super(message)
  end
end
