# frozen_string_literal: true

require 'spec_helper'
require 'issn_helper'

RSpec.describe ISSNHelper do
  it 'returns ISSN unchanged if it is valid' do
    expect(described_class.issn('1234-5678')).to eq('1234-5678')
  end

  it 'adds a dash if it is missing' do
    expect(described_class.issn('12345678')).to eq('1234-5678')
  end
end
