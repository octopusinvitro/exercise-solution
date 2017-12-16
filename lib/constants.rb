# frozen_string_literal: true

module Constants
  ARGV_SIZE = 5
  VALID_OUTPUT_FORMATS = %w[json csv].freeze
  JOURNALS_REQUIRED_COLUMNS = %i[title issn].freeze
  ARTICLES_REQUIRED_COLUMNS = %i[doi title issn].freeze
  AUTHORS_SCHEMA_PATH = 'lib/json_schemas/authors_schema.json'
end
