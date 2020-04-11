# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::AlcomarketParser do
  link = 'https://alcomarket.md/ru/product/viski-jack-daniel-s-honey-1l/'
  parser_hash_item = {
    name: 'Виски Jack Daniel’s Honey 1л',
    price: '532',
    image: 'https://alcomarket.md/media/images/'\
           'items/0005/th2/items-4998-887.png',
    currency: 'MDL',
    availability: false
  }

  include_examples 'Parser',
                   'alcomarket',
                   link,
                   parser_hash_item
end
