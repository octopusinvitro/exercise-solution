# frozen_string_literal: true

require 'spec_helper'
require 'combinator'

RSpec.describe Combinator do
  it 'example test' do
    argv = %w[foo bar]
    expect(described_class.run(argv)).to eq(argv)
  end
end
