# frozen_string_literal: true

require 'spec_helper'
require 'combinator'

RSpec.describe Combinator do
  let(:valid_authors_json) do
    '[{"name":"Akeem Toy",' \
    '"articles":["10.1234/altmetric846","10.1234/altmetric93"]},' \
    '{"name":"Annamarie Nader",' \
    '"articles":["10.1234/altmetric829","10.1234/altmetric736"]}]'
  end
  let(:journals) { new_tempfile("Title,ISSN\nfoo,bar", 'journals.csv') }
  let(:articles) { new_tempfile("DOI,Title,ISSN\nfoo,bar,qux", 'articles.csv') }
  let(:authors) { new_tempfile(valid_authors_json, 'authors.csv') }

  it 'works if input args are valid' do
    argv = ['--format', 'json', journals, articles, authors]
    expect(described_class.run(argv)).to eq(argv)
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
end
