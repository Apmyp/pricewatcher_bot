# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::PegasParser do
  link = 'https://www.pegas.md/ru/pages/shop/1/27/32/687/'
  parser_hash_item = {
    name: 'Виски \'Jack Daniels\' 1 л',
    price: '583',
    image: 'https://pegas.md/public/catalog/'\
           'thumbs/version_900x900x1/_MG_1542_web.jpg',
    currency: 'MDL',
    availability: true
  }

  include_examples 'Parser',
                   'pegas',
                   link,
                   parser_hash_item
end
