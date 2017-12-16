# frozen_string_literal: true

require_relative 'input_args_validator'

class Combinator
  def self.run(argv)
    new(argv).run
  end

  def initialize(argv)
    @argv = argv
  end

  def run
    InputArgsValidator.validate(argv)
    argv
  end

  private

  attr_reader :argv
end
