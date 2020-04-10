# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::MoonglowParser do
  link = 'https://moonglow.md/ro/products/dr-ceuracle-deesse-ac-spot-healer'
  parser_hash_item = {
    name: 'DR.CEURACLE DÉESSE AC SPOT HEALER',
    price: '495',
    image: 'https://moonglow.md/files/2020-02-26/images/medium/1821051_1-_-1582730461.jpg',
    currency: 'MDL',
    availability: true
  }

  include_examples 'Parser',
                   'moonglow',
                   link,
                   parser_hash_item
end
