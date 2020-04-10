# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::OriginParser do
  link = 'https://origin.md/ru/product/tufli-clarks-un-larvik-lace-brown-leather'
  parser_hash_item = {
    name: 'Туфли мужские Un Larvik Lace Brown Leather',
    price: '1912'
  }

  include_examples 'Parser',
                   'origin',
                   link,
                   parser_hash_item
end
