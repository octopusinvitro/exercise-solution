# frozen_string_literal: true

require 'spec_helper'
require 'json_authors_parser'

RSpec.describe JSONAuthorsParser do
  it 'swaps authors with articles to articles with authors' do
    content = '[{"name":"A Name","articles":["doi1", "doi2"]}]'
    path = new_tempfile(content, 'journals.csv')
    parsed = {
      'doi1': ['A Name'],
      'doi2': ['A Name']
    }
    expect(described_class.parse(path)).to eq(parsed)
  end

  it 'accumulates authors in the same doi' do
    content = '[{"name":"Name1","articles":["doi"]},' \
              '{"name":"Name2","articles":["doi"]}]'
    path = new_tempfile(content, 'journals.csv')
    parsed = {
      'doi': %w[Name1 Name2]
    }
    expect(described_class.parse(path)).to eq(parsed)
  end
end
