# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::SonycenterParser do
  context 'with sale' do
    link = 'https://sonycenter.md/ru/shop/wh1000xm3/'
    parser_hash_item = {
      name: 'WH1000XM3 - SONY',
      price: '5799',
      image: 'https://sonycenter.md/wp-content/uploads/2018/09/1000xm3.jpg',
      currency: 'MDL',
      availability: true
    }

    include_examples 'Parser',
                     'sonycenter',
                     link,
                     parser_hash_item
  end

  context 'without sale' do
    link = 'https://sonycenter.md/ru/category/naushniki/'
    parser_hash_item = {
      name: 'WH-L600 - SONY',
      price: '4899',
      image: 'https://sonycenter.md/wp-content/uploads/2018/04/whl600.jpeg',
      currency: 'MDL',
      availability: true
    }

    include_examples 'Parser',
                     'sonycenter_without_sale',
                     link,
                     parser_hash_item
  end
end
