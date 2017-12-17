# frozen_string_literal: true

module Constants
  ARGV_SIZE = 5
  VALID_OUTPUT_FORMATS = %w[json csv].freeze

  JOURNALS_TITLE_COLUMN = :title
  JOURNALS_ISSN_COLUMN = :issn
  JOURNALS_REQUIRED_COLUMNS = [
    JOURNALS_TITLE_COLUMN, JOURNALS_ISSN_COLUMN
  ].freeze

  ARTICLES_DOI_COLUMN = :doi
  ARTICLES_TITLE_COLUMN = :title
  ARTICLES_ISSN_COLUMN = :issn
  ARTICLES_REQUIRED_COLUMNS = [
    ARTICLES_DOI_COLUMN, ARTICLES_TITLE_COLUMN, ARTICLES_ISSN_COLUMN
  ].freeze

  AUTHORS_NAME_PROPERTY = 'name'
  AUTHORS_DOIS_PROPERTY = 'articles'
  AUTHORS_SCHEMA_PATH = 'lib/json_schemas/authors_schema.json'

  OUTPUT_DOI_COLUMN = 'DOI'
  OUTPUT_TITLE_COLUMN = 'Title'
  OUTPUT_AUTHOR_COLUMN = 'Author'
  OUTPUT_JOURNAL_COLUMN = 'Journal'
  OUTPUT_ISSN_COLUMN = 'ISSN'

  UNKNOWN_AUTHOR = 'Unknown author'
  UNKNOWN_JOURNAL = 'Unknown journal'
end
