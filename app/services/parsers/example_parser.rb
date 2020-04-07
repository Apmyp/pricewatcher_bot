# frozen_string_literal: true

module Parsers
  class ExampleParser < Parser
    class << self
      def host
        'example.com'
      end

      def paths
        [
          %r{[^/]*}
        ]
      end
    end

    def call; end
  end
end
