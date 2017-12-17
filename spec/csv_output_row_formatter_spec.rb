# frozen_string_literal: true

require 'spec_helper'
require 'csv_output_row_formatter'

RSpec.describe CSVOutputRowFormatter do
  let(:issns_to_journals) do
    { '1234-5678': 'A journal', '8765-4321': 'Old journal' }
  end
  let(:dois_to_authors) do
    { 'doi1': ['A Name'], 'doi2': ['A Name', 'Another Name'] }
  end

  it 'formats a hash row as a comma-separated merged-fields list' do
    row = { doi: 'doi1', title: 'A title', issn: '1234-5678' }
    formatted = 'doi1,A title,A Name,A journal,1234-5678'
    expect(described_class.row(issns_to_journals, dois_to_authors, row))
      .to eq(formatted)
  end

  it 'joins the authors with a ; when there are several' do
    row = { doi: 'doi2', title: 'Another title', issn: '8765-4321' }
    formatted = 'doi2,Another title,A Name;Another Name,Old journal,8765-4321'
    expect(described_class.row(issns_to_journals, dois_to_authors, row))
      .to eq(formatted)
  end

  it 'fixes ISSNs with no dashes' do
    row = { doi: 'doi1', title: 'A title', issn: '12345678' }
    formatted = 'doi1,A title,A Name,A journal,1234-5678'
    expect(described_class.row(issns_to_journals, dois_to_authors, row))
      .to eq(formatted)
  end

  it 'returns unknown author if DOI not found in authors' do
    row = { doi: 'doi', title: 'A title', issn: '1234-5678' }
    formatted = 'doi,A title,Unknown author,A journal,1234-5678'
    expect(described_class.row(issns_to_journals, dois_to_authors, row))
      .to eq(formatted)
  end

  it 'returns unknown journal if ISSN not found in journals' do
    row = { doi: 'doi1', title: 'A title', issn: '5678-1234' }
    formatted = 'doi1,A title,A Name,Unknown journal,5678-1234'
    expect(described_class.row(issns_to_journals, dois_to_authors, row))
      .to eq(formatted)
  end

  it 'knows the headers' do
    expect(described_class.headers).to eq('DOI,Title,Author,Journal,ISSN')
  end
end
