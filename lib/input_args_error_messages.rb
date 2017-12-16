# frozen_string_literal: true

module InputArgsErrorMessages
  USAGE = 'Usage: ruby combine.rb --format (json|csv) ' \
          'path/to/journals.csv path/to/articles.csv ' \
          'path/to/authors.json > output_filename'
  MISSING_INPUT = 'Missing input argument'
  WRONG_FORMAT = 'Wrong output file format'
  MISSING_JOURNALS_FILE = 'Journals file not found'
  MISSING_ARTICLES_FILE = 'Articles file not found'
  MISSING_AUTHORS_FILE = 'Authors file not found'
end
