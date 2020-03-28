module Parsers
  class ParserItemDiffers
    def self.call(first_parser_item, second_parser_item)
      new.call(first_parser_item, second_parser_item)
    end

    def call(first_parser_item, second_parser_item)
      diff = {}.tap do |hash|
        first_attrs = first_parser_item.instance_variable_get('@attributes')
        second_attrs = second_parser_item.instance_variable_get('@attributes')

        first_attrs.each do |key, first_value|
          second_value = second_attrs[key]
          hash[key] = second_value if first_value != second_value
        end
      end

      return nil if diff.keys.size.zero?

      diff
    end
  end
end