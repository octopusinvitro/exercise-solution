# frozen_string_literal: true

require 'spec_helper'
require 'combinator'

RSpec.describe Combinator do
  let(:journals) do
    new_tempfile("Title,ISSN\nJournal name,1234-5678", 'journals.csv')
  end
  let(:articles) do
    new_tempfile("DOI,Title,ISSN\ndoi1,Title2,1234-5678", 'articles.csv')
  end
  let(:authors) do
    valid_authors_json =
      '[{"name":"A Name","articles":["doi1","doi2"]},' \
      '{"name":"Another Name","articles":["doi2","doi3"]}]'
    new_tempfile(valid_authors_json, 'authors.csv')
  end

  it 'raises an error if input args are invalid' do
    argv = %w[--format yaml journals articles authors]
    expect { described_class.run(argv) }.to raise_error(InputArgsError)
  end

  it 'raises an error if files are invalid' do
    journals = new_tempfile(nil, 'journals.csv')
    argv = ['--format', 'json', journals, articles, authors]
    expect { described_class.run(argv) }.to raise_error(InputFilesError)
  end

  it 'spits CSV if inputs are valid' do
    argv = ['--format', 'csv', journals, articles, authors]
    csv = "DOI,Title,Author,Journal,ISSN\n" \
          'doi1,Title2,A Name,Journal name,1234-5678'
    expect(described_class.run(argv)).to eq(csv)
  end

  it 'spits JSON if inputs are valid' do
    argv = ['--format', 'json', journals, articles, authors]
    json = [
      {
        'doi' => 'doi1',
        'title' => 'Title2',
        'author' => ['A Name'],
        'journal' => 'Journal name',
        'issn' => '1234-5678'
      }
    ].to_json
    expect(described_class.run(argv)).to eq(json)
  end
end
