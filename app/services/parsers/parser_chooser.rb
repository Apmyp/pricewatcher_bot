module Parsers
  class ParserChooser

    class ParserNotFoundException < ::Exception; end

    def self.call(link)
      new.call(link)
    end

    def call(link)
      if link.host == 'pumamoldova.md'
        PumaMoldovaParser
      else
        raise ParserNotFoundException.new
      end
    end
  end
end