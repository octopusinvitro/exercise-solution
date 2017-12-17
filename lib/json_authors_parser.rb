# frozen_string_literal: true

require 'json'
require_relative 'constants'

class JSONAuthorsParser
  include Constants

  def self.parse(path)
    new(path).parse
  end

  def initialize(path)
    @path = path
    @dois = {}
  end

  def parse
    reverse
    dois
  end

  private

  attr_reader :path, :dois

  def reverse
    authors_to_dois.each { |author| dois_to_authors(author) }
  end

  def authors_to_dois
    @authors_to_dois ||= JSON.parse(read_authors)
  end

  def read_authors
    File.read(path)
  end

  def dois_to_authors(author)
    author[AUTHORS_DOIS_PROPERTY].each do |doi|
      add_name_to_doi(doi, author[AUTHORS_NAME_PROPERTY])
    end
  end

  def add_name_to_doi(doi, name)
    (dois[doi.to_sym] ||= []) << name
  end
end
