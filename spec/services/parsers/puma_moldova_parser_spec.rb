# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::PumaMoldovaParser do
  link = 'http://pumamoldova.md/ru/shop/male/footwear/lifestyle/370846-05'
  parser_hash_item = {
    name: 'Кроссовки Puma Ralph Sampson Lo',
    price: '1199',
    image: 'http://pumamoldova.md/images/products/jpg/37084605.jpg',
    currency: 'MDL',
    availability: true
  }

  include_examples 'Parser',
                   'puma_moldova',
                   link,
                   parser_hash_item
end
