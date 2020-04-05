# frozen_string_literal: true

module Parsers
  class ParserChooser
    class ParserNotFoundException < RuntimeError; end

    class << self
      attr_writer :parsers

      def call(*args)
        new.call(*args)
      end

      def parsers
        @parsers || []
      end

      def parsers_hosts
        parsers.map { |c| c.public_send(:host) }.join("\n")
      end
    end

    def call(link)
      self.class.parsers.find do |parser_const|
        host = parser_const.public_send(:host)
        paths = parser_const.public_send(:paths)

        link.host == host && paths.any? { |p| link.path[p] }
      end || raise(ParserNotFoundException)
    end
  end
end
