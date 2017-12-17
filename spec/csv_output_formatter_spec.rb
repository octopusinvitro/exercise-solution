# frozen_string_literal: true

require 'spec_helper'
require 'csv_output_formatter'

RSpec.describe CSVOutputFormatter do
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
    "DOI,Title,Author,Journal,ISSN\n" \
    "doi1,Title 1,A Name,Journal 1,1234-5678\n" \
    'doi2,Title 2,Another Name,Journal 2,8765-4321'
  end

  it 'merges all files into a CSV with headers sorted by doi' do
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
      expect(described_class.output(file_paths)).to eq(valid_output_csv)
    end

    def valid_output_csv
      @valid_output_csv ||= File.read("#{TEST_FILES_PATH}/output.csv")
    end
  end
end
