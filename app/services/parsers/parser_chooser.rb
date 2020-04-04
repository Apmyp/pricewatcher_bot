# frozen_string_literal: true

module Parsers
  class ParserChooser
    class ParserNotFoundException < RuntimeError; end

    def self.call(*args)
      new.call(*args)
    end

    def call(link)
      raise ParserNotFoundException unless link.host == 'pumamoldova.md'

      PumaMoldovaParser
    end
  end
end
