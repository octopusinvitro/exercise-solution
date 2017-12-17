# frozen_string_literal: true

require 'spec_helper'
require 'input_args_validator'

RSpec.describe InputArgsValidator do
  let(:input_args) { %w[--format json journals articles authors] }
  let(:file_paths) do
    {
      journals: 'journals', articles: 'articles', authors: 'authors'
    }
  end

  it 'knows the output file format' do
    expect(described_class.output_format(input_args)).to eq('json')
  end

  it 'knows the file paths' do
    expect(described_class.file_paths(input_args)).to eq(file_paths)
  end

  describe('when validation succeeds') do
    it 'validates' do
      allow(File).to receive(:file?).and_return(true)
      expect(described_class.validate(input_args)).to eq(file_paths)
    end
  end

  describe('when validation fails') do
    it 'detects missing input arguments' do
      expect { described_class.validate(%w[foo bar]) }
        .to raise_error(InputArgsError)
        .with_message(/#{described_class::MISSING_INPUT}/)
    end

    it 'detects wrong output format' do
      input_args[1] = 'yaml'
      expect { described_class.validate(input_args) }
        .to raise_error(InputArgsError)
        .with_message(/#{described_class::WRONG_FORMAT}/)
    end

    it 'detects if journals file does not exist' do
      expect { described_class.validate(input_args) }
        .to raise_error(InputArgsError)
        .with_message(/#{described_class::MISSING_JOURNALS_FILE}/)
    end

    it 'detects if articles file does not exist' do
      expect { described_class.validate(input_args) }
        .to raise_error(InputArgsError)
        .with_message(/#{described_class::MISSING_ARTICLES_FILE}/)
    end

    it 'detects if authors file does not exist' do
      expect { described_class.validate(input_args) }
        .to raise_error(InputArgsError)
        .with_message(/#{described_class::MISSING_AUTHORS_FILE}/)
    end

    it 'joins all error messages' do
      messages = Regexp.union(
        described_class::MISSING_JOURNALS_FILE,
        described_class::MISSING_ARTICLES_FILE
      )
      expect { described_class.validate(input_args) }
        .to raise_error(InputArgsError).with_message(messages)
    end
  end
end
