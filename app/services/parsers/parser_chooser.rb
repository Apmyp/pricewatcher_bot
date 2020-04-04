module Parsers
  class ParserChooser

    class ParserNotFoundException < ::Exception; end

    def self.call(*args)
      new.call(*args)
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