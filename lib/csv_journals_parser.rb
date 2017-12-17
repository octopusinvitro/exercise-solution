# frozen_string_literal: true

require 'csv'

require_relative 'constants'
require_relative 'issn_helper'

class CSVJournalsParser
  def self.parse(path)
    new(path).parse
  end

  def initialize(path)
    @path = path
    @options = { headers: true, header_converters: :symbol }
    @pairs = []
  end

  def parse
    read_csv
    hashify
  end

  private

  attr_reader :path, :options, :pairs

  def read_csv
    CSV.foreach(path, options) { |row| add_pair(row) }
  end

  def add_pair(row)
    pairs << PairFormatter.pair(row)
  end

  def hashify
    pairs.to_h
  end

  class PairFormatter
    include Constants

    def self.pair(row)
      new(row).pair
    end

    def initialize(row)
      @row = row
    end

    def pair
      [issn, title]
    end

    private

    attr_reader :row

    def issn
      ISSNHelper.issn(row[JOURNALS_ISSN_COLUMN]).to_sym
    end

    def title
      row[JOURNALS_TITLE_COLUMN]
    end
  end
end
