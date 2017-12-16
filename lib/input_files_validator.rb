# frozen_string_literal: true

require 'csv'
require 'json-schema'

require_relative 'constants'
require_relative 'input_files_error_messages'
require_relative 'input_files_error'
require_relative 'result'

class InputFilesValidator
  include Constants
  include InputFilesErrorMessages

  def self.validate(file_paths)
    new(file_paths).validate
  end

  def initialize(journals:, articles:, authors:)
    @journals = journals
    @articles = articles
    @authors = authors
  end

  def validate
    raise(InputFilesError, error_message) unless validation.okay?
    true
  end

  private

  attr_reader :journals, :articles, :authors

  def error_message
    validation.errors.join("\n")
  end

  def validation
    @validation ||= result
  end

  def result
    result = Result.new
    result << validate_journals_file
    result << validate_articles_file
    result << validate_authors_file
    result
  end

  def validate_journals_file
    MALFORMED_JOURNALS_FILE unless well_formed_csv?(
      journals, JOURNALS_REQUIRED_COLUMNS
    )
  end

  def validate_articles_file
    MALFORMED_ARTICLES_FILE unless well_formed_csv?(
      articles, ARTICLES_REQUIRED_COLUMNS
    )
  end

  def validate_authors_file
    MALFORMED_AUTHORS_FILE unless well_formed_json?(
      authors, AUTHORS_SCHEMA_PATH
    )
  end

  def well_formed_csv?(path, required_columns)
    headers = read_csv(path).headers
    contains_all_required_columns?(headers, required_columns)
  end

  def contains_all_required_columns?(all_columns, required_columns)
    all_columns & required_columns == required_columns
  end

  def read_csv(path)
    CSV.read(
      path,
      headers: true, converters: :numeric, header_converters: :symbol
    )
  end

  def well_formed_json?(instance_path, schema_path)
    JSON::Validator.validate(
      schema_path, File.read(instance_path), strict: true
    )
  end
end
