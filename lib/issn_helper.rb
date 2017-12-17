# frozen_string_literal: true

class ISSNHelper
  def self.issn(raw_issn)
    new(raw_issn).issn
  end

  def initialize(raw_issn)
    @raw_issn = raw_issn
  end

  def issn
    insert_dash unless includes_dash?
    raw_issn
  end

  private

  attr_reader :raw_issn

  def insert_dash
    @raw_issn = raw_issn.dup.insert(4, '-')
  end

  def includes_dash?
    raw_issn =~ /[\S]{4}\-[\S]{4}/
  end
end
