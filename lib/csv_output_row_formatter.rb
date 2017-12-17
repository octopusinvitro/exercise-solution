# frozen_string_literal: true

require_relative 'constants'
require_relative 'issn_helper'

class CSVOutputRowFormatter
  include Constants

  def self.row(issns_to_journals, dois_to_authors, raw_row)
    new(issns_to_journals, dois_to_authors, raw_row).row
  end

  def self.headers
    [
      OUTPUT_DOI_COLUMN, OUTPUT_TITLE_COLUMN, OUTPUT_AUTHOR_COLUMN,
      OUTPUT_JOURNAL_COLUMN, OUTPUT_ISSN_COLUMN
    ].join(',')
  end

  def initialize(issns_to_journals, dois_to_authors, raw_row)
    @issns_to_journals = issns_to_journals
    @dois_to_authors = dois_to_authors
    @raw_row = raw_row
  end

  def row
    [doi, title, author, journal, issn].join(',')
  end

  private

  attr_reader :issns_to_journals, :dois_to_authors, :raw_row

  def doi
    raw_row[ARTICLES_DOI_COLUMN]
  end

  def title
    raw_row[ARTICLES_TITLE_COLUMN]
  end

  def author
    (dois_to_authors[doi.to_sym] || [UNKNOWN_AUTHOR]).join(';')
  end

  def journal
    issns_to_journals[issn.to_sym] || UNKNOWN_JOURNAL
  end

  def issn
    ISSNHelper.issn(raw_row[ARTICLES_ISSN_COLUMN])
  end
end
