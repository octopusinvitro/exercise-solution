# frozen_string_literal: true

require 'spec_helper'
require 'result'

RSpec.describe Result do
  it 'adds an error message to the list' do
    result = described_class.new
    result << 'error message'
    expect(result.errors).to include('error message')
  end

  it 'does not add a null message' do
    result = described_class.new
    result << nil
    expect(result.errors).to be_empty
  end

  it 'is okay if there are no errors' do
    result = described_class.new
    expect(result.okay?).to be_truthy
  end
end
