# frozen_string_literal: true

require 'spec_helper'
require 'input_files_error'

RSpec.describe InputFilesError do
  it 'raises exception with a custom message' do
    expect { raise described_class, 'foo' }
      .to raise_error(described_class, 'foo')
  end
end
