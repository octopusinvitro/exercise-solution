# frozen_string_literal: true

module Constants
  ARGV_SIZE = 5
  VALID_OUTPUT_FORMATS = %w[json csv].freeze
  JOURNALS_TITLE_COLUMN = :title
  JOURNALS_ISSN_COLUMN = :issn
  JOURNALS_REQUIRED_COLUMNS = [
    JOURNALS_TITLE_COLUMN, JOURNALS_ISSN_COLUMN
  ].freeze
  ARTICLES_REQUIRED_COLUMNS = %i[doi title issn].freeze
  AUTHORS_NAME_PROPERTY = 'name'
  AUTHORS_DOIS_PROPERTY = 'articles'
  AUTHORS_SCHEMA_PATH = 'lib/json_schemas/authors_schema.json'
end
