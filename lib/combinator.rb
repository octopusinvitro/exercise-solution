# frozen_string_literal: true

class Combinator
  def self.run(argv)
    new(argv).run
  end

  def initialize(argv)
    @argv = argv
  end

  def run
    argv
  end

  private

  attr_reader :argv
end
