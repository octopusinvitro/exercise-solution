# frozen_string_literal: true

require_relative 'constants'
require_relative 'input_args_error'
require_relative 'result'
require_relative 'input_args_error_messages'

class InputArgsValidator
  include Constants
  include InputArgsErrorMessages

  def self.validate(argv)
    new(argv).validate
  end

  def self.output_format(argv)
    argv[1]
  end

  def self.file_paths(argv)
    { journals: argv[2], articles: argv[3], authors: argv[4] }
  end

  def initialize(argv)
    @size = argv.size
    @output_format = self.class.output_format(argv)
    @file_paths = self.class.file_paths(argv)
  end

  def validate
    raise(InputArgsError, error_message) unless validation.okay?
    file_paths
  end

  private

  attr_reader :size, :output_format, :file_paths

  def error_message
    errors = validation.errors.join("\n")
    "#{errors}\n#{USAGE}"
  end

  def validation
    result = Result.new
    result << validate_args_size
    result << validate_output_format
    result << validate_journals_existence
    result << validate_articles_existence
    result << validate_authors_existence
    result
  end

  def validate_args_size
    MISSING_INPUT unless size == ARGV_SIZE
  end

  def validate_output_format
    WRONG_FORMAT unless VALID_OUTPUT_FORMATS.include?(output_format)
  end

  def validate_journals_existence
    MISSING_JOURNALS_FILE unless file_exists?(file_paths[:journals])
  end

  def validate_articles_existence
    MISSING_ARTICLES_FILE unless file_exists?(file_paths[:articles])
  end

  def validate_authors_existence
    MISSING_AUTHORS_FILE unless file_exists?(file_paths[:authors])
  end

  def file_exists?(path)
    File.file?(path || '')
  end
end
