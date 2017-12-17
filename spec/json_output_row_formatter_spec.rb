# frozen_string_literal: true

require 'spec_helper'
require 'json_output_row_formatter'

RSpec.describe JSONOutputRowFormatter do
  let(:issns_to_journals) do
    { '1234-5678': 'A journal', '8765-4321': 'Old journal' }
  end
  let(:dois_to_authors) do
    { 'doi1': ['A Name'], 'doi2': ['A Name', 'Another Name'] }
  end
  let(:formatted1) do
    {
      'doi' => 'doi1',
      'title' => 'A title',
      'author' => ['A Name'],
      'journal' => 'A journal',
      'issn' => '1234-5678'
    }
  end
  let(:formatted2) do
    {
      'doi' => 'doi2',
      'title' => 'Another title',
      'author' => ['A Name', 'Another Name'],
      'journal' => 'Old journal',
      'issn' => '8765-4321'
    }
  end

  it 'formats a hash row as a hash of merged-fields' do
    row = { doi: 'doi1', title: 'A title', issn: '1234-5678' }
    expect(described_class.row(issns_to_journals, dois_to_authors, row))
      .to eq(formatted1)
  end

  it 'returns and array of authors when there are several' do
    row = { doi: 'doi2', title: 'Another title', issn: '8765-4321' }
    expect(described_class.row(issns_to_journals, dois_to_authors, row))
      .to eq(formatted2)
  end

  it 'fixes ISSNs with no dashes' do
    row = { doi: 'doi1', title: 'A title', issn: '12345678' }
    expect(described_class.row(issns_to_journals, dois_to_authors, row))
      .to eq(formatted1)
  end

  it 'returns unknown author if DOI not found in authors' do
    row = { doi: 'doi', title: 'A title', issn: '1234-5678' }
    formatted = formatted1.merge('doi' => 'doi', 'author' => ['Unknown author'])
    expect(described_class.row(issns_to_journals, dois_to_authors, row))
      .to eq(formatted)
  end

  it 'returns unknown journal if ISSN not found in journals' do
    row = { doi: 'doi1', title: 'A title', issn: '5678-1234' }
    formatted = formatted1.merge(
      'journal' => 'Unknown journal', 'issn' => '5678-1234'
    )
    expect(described_class.row(issns_to_journals, dois_to_authors, row))
      .to eq(formatted)
  end
end
