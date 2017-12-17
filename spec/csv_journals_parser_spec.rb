# frozen_string_literal: true

require 'spec_helper'
require 'csv_journals_parser'

RSpec.describe CSVJournalsParser do
  it 'creates a hash with the ISSN as key' do
    content = "Title,ISSN\nA title,1234-5678\nAnother title,8765-4321"
    path = new_tempfile(content, 'journals.csv')
    parsed = { '1234-5678': 'A title', '8765-4321': 'Another title' }
    expect(described_class.parse(path)).to eq(parsed)
  end

  it 'converts ISSN numbers if they have no dash' do
    content = "Title,ISSN\nA title,12345678\nAnother title,87654321"
    path = new_tempfile(content, 'journals.csv')
    parsed = { '1234-5678': 'A title', '8765-4321': 'Another title' }
    expect(described_class.parse(path)).to eq(parsed)
  end
end
