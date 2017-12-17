# frozen_string_literal: true

require_relative 'constants'
require_relative 'csv_output_formatter'
require_relative 'json_output_formatter'
require_relative 'input_args_validator'
require_relative 'input_files_validator'

class Combinator
  include Constants

  def self.run(argv)
    new(argv).run
  end

  def initialize(argv)
    @argv = argv
  end

  def run
    validate_inputs
    combine_files
  end

  private

  attr_reader :argv

  def validate_inputs
    InputArgsValidator.validate(argv)
    InputFilesValidator.validate(file_paths)
  end

  def combine_files
    if csv?
      CSVOutputFormatter.output(file_paths)
    else
      JSONOutputFormatter.output(file_paths)
    end
  end

  def file_paths
    InputArgsValidator.file_paths(argv)
  end

  def csv?
    InputArgsValidator.output_format(argv) == CSV_FORMAT
  end
end
