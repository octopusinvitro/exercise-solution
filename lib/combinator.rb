# frozen_string_literal: true

require_relative 'input_args_validator'
require_relative 'input_files_validator'

class Combinator
  def self.run(argv)
    new(argv).run
  end

  def initialize(argv)
    @argv = argv
  end

  def run
    file_paths = InputArgsValidator.validate(argv)
    InputFilesValidator.validate(file_paths)
    argv
  end

  private

  attr_reader :argv
end
