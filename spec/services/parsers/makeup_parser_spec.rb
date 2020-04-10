# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::MakeupParser do
  context 'ro' do
    link = 'https://makeup.md/product/314655/'
    parser_hash_item = {
      name: 'Balsam de păr pentru uz zilnic',
      price: '663',
      image: 'https://i.makeup.md/s/sp/sph0giazcbby.jpg',
      currency: 'MDL',
      availability: true
    }

    include_examples 'Parser',
                     'makeup',
                     link,
                     parser_hash_item
  end

  context 'ru' do
    link = 'https://makeup.md/ru/product/314655/'
    parser_hash_item = {
      name: 'Кондиционер для ежедневного использования',
      price: '663',
      image: 'https://i.makeup.md/s/sp/sph0giazcbby.jpg',
      currency: 'МДЛ',
      availability: true
    }

    include_examples 'Parser',
                     'makeup_ru',
                     link,
                     parser_hash_item
  end

  context 'sold' do
    link = 'https://makeup.md/ru/product/314655/'
    parser_hash_item = {
      name: 'Pensulă pentru farduri de ochi 228',
      price: '0',
      image: 'https://i.makeup.md/f/f0/f0kiditvucud.jpg',
      currency: 'МДЛ',
      availability: false
    }

    include_examples 'Parser',
                     'makeup_sold',
                     link,
                     parser_hash_item
  end
end
