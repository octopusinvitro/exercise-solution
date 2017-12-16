# frozen_string_literal: true

require 'spec_helper'
require 'input_files_validator'

RSpec.describe InputFilesValidator do
  let(:valid_authors_json) do
    '[{"name":"Akeem Toy",' \
    '"articles":["10.1234/altmetric846","10.1234/altmetric93"]},' \
    '{"name":"Annamarie Nader",' \
    '"articles":["10.1234/altmetric829","10.1234/altmetric736"]}]'
  end
  let(:file_paths) do
    {
      journals: new_tempfile("Title,ISSN\nfoo,bar", 'journals.csv'),
      articles: new_tempfile("DOI,Title,ISSN\nfoo,bar,qux", 'articles.csv'),
      authors: new_tempfile(valid_authors_json, 'authors.csv')
    }
  end

  describe('when validation succeeds') do
    it 'validates' do
      expect(described_class.validate(file_paths)).to be_truthy
    end
  end

  describe('when validation fails') do
    it 'detects missing required columns in journals' do
      file_paths[:journals] = new_tempfile(nil, 'journals.csv')
      expect { described_class.validate(file_paths) }
        .to raise_error(InputFilesError)
        .with_message(/#{described_class::MALFORMED_JOURNALS_FILE}/)
    end

    it 'detects missing required columns in articles' do
      file_paths[:articles] = new_tempfile(nil, 'articles.csv')
      expect { described_class.validate(file_paths) }
        .to raise_error(InputFilesError)
        .with_message(/#{described_class::MALFORMED_ARTICLES_FILE}/)
    end

    it 'detects missing required data in authors' do
      file_paths[:authors] = new_tempfile(nil, 'authors.json')
      expect { described_class.validate(file_paths) }
        .to raise_error(InputFilesError)
        .with_message(/#{described_class::MALFORMED_AUTHORS_FILE}/)
    end

    it 'joins all error messages' do
      file_paths[:journals] = new_tempfile(nil, 'journals.csv')
      file_paths[:authors]  = new_tempfile(nil, 'authors.json')
      messages = Regexp.union(
        described_class::MALFORMED_JOURNALS_FILE,
        described_class::MALFORMED_AUTHORS_FILE
      )
      expect { described_class.validate(file_paths) }
        .to raise_error(InputFilesError).with_message(messages)
    end
  end
end
