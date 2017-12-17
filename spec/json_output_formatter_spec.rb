# frozen_string_literal: true

require 'spec_helper'
require 'json_output_formatter'

RSpec.describe JSONOutputFormatter do
  let(:journals) do
    "Title,ISSN\n" \
    "Journal 1,1234-5678\n" \
    "Journal 2,8765-4321\n"
  end
  let(:articles) do
    "DOI,Title,ISSN\n" \
    "doi1,Title 1,1234-5678\n" \
    "doi2,Title 2,8765-4321\n"
  end
  let(:authors) do
    '[{"name":"A Name","articles":["doi1"]},' \
    '{"name":"Another Name","articles":["doi2"]}]'
  end
  let(:file_paths) do
    {
      journals: new_tempfile(journals, 'journals.csv'),
      articles: new_tempfile(articles, 'articles.csv'),
      authors: new_tempfile(authors, 'authors.json')
    }
  end
  let(:output) do
    [
      {
        'doi' => 'doi1',
        'title' => 'Title 1',
        'author' => ['A Name'],
        'journal' => 'Journal 1',
        'issn' => '1234-5678'
      },
      {
        'doi' => 'doi2',
        'title' => 'Title 2',
        'author' => ['Another Name'],
        'journal' => 'Journal 2',
        'issn' => '8765-4321'
      }
    ].to_json
  end

  it 'merges all files into a JSON with objects sorted by DOI' do
    expect(described_class.output(file_paths)).to eq(output)
  end

  describe 'with real files' do
    let(:file_paths) do
      {
        journals: "#{TEST_FILES_PATH}/journals.csv",
        articles: "#{TEST_FILES_PATH}/articles.csv",
        authors: "#{TEST_FILES_PATH}/authors.json"
      }
    end

    it 'works' do
      expect(described_class.output(file_paths)).to eq(valid_output_json)
    end

    def valid_output_json
      @valid_output_json ||= File.read("#{TEST_FILES_PATH}/output.json")
    end
  end
end
