# frozen_string_literal: true

require 'json'

require_relative 'constants'
require_relative 'csv_journals_parser'
require_relative 'json_authors_parser'
require_relative 'json_output_row_formatter'

class JSONOutputFormatter
  include Constants

  def self.output(file_paths)
    new(file_paths).output
  end

  def initialize(journals:, articles:, authors:)
    @journals = journals
    @articles = articles
    @authors = authors
    @options = { headers: true, header_converters: :symbol }
    @rows = []
  end

  def output
    merge_files
    sort_rows
    stringify
  end

  private

  attr_reader :journals, :articles, :authors, :options, :rows

  def merge_files
    CSV.foreach(articles, options) { |row| format_row(row) }
  end

  def format_row(row)
    rows << JSONOutputRowFormatter.row(issns_to_journals, dois_to_authors, row)
  end

  def sort_rows
    @rows = rows.dup.sort_by { |row| row[OUTPUT_DOI_PROPERTY] }
  end

  def stringify
    rows.to_json
  end

  def issns_to_journals
    @issns_to_journals ||= CSVJournalsParser.parse(journals)
  end

  def dois_to_authors
    @dois_to_authors ||= JSONAuthorsParser.parse(authors)
  end
end
