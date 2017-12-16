# frozen_string_literal: true

module InputFilesErrorMessages
  MALFORMED_JOURNALS_FILE = 'Journals file needs Title and ISSN columns'
  MALFORMED_ARTICLES_FILE = 'Articles file needs DOI, Title and ISSN columns'
  MALFORMED_AUTHORS_FILE = 'Authors file needs to validate against the specs ' \
                           'defined in "lib/json_schemas/authors_schema.json"'
end
