# frozen_string_literal: true

require 'spec_helper'
require 'combinator'

RSpec.describe Combinator do
  it 'works if input args are valid' do
    argv = %w[--format json journals articles authors]
    allow(File).to receive(:file?).and_return(true)
    expect(described_class.run(argv)).to eq(argv)
  end

  it 'raises an error if input args are invalid' do
    argv = %w[--format yaml journals articles authors]
    expect { described_class.run(argv) }.to raise_error(InputArgsError)
  end
end
