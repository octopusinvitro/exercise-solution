# frozen_string_literal: true

require_relative 'constants'
require_relative 'issn_helper'

class JSONOutputRowFormatter
  include Constants

  def self.row(issns_to_journals, dois_to_authors, raw_row)
    new(issns_to_journals, dois_to_authors, raw_row).row
  end

  def initialize(issns_to_journals, dois_to_authors, raw_row)
    @issns_to_journals = issns_to_journals
    @dois_to_authors = dois_to_authors
    @raw_row = raw_row
  end

  def row
    {
      OUTPUT_DOI_PROPERTY => doi,
      OUTPUT_TITLE_PROPERTY => title,
      OUTPUT_AUTHOR_PROPERTY => author,
      OUTPUT_JOURNAL_PROPERTY => journal,
      OUTPUT_ISSN_PROPERTY => issn
    }
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
    (dois_to_authors[doi.to_sym] || [UNKNOWN_AUTHOR])
  end

  def journal
    issns_to_journals[issn.to_sym] || UNKNOWN_JOURNAL
  end

  def issn
    ISSNHelper.issn(raw_row[ARTICLES_ISSN_COLUMN])
  end
end
