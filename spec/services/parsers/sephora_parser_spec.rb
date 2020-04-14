# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::SephoraParser do
  context 'with default page' do
    link = 'https://www.sephora.com/product/peach-kiss-moisture-matte'\
         '-long-wear-lipstick-peaches-cream-collection-P422600'\
         '?skuId=2108157&icid2=products%20grid:p422600'
    parser_hash_item = {
      name: 'Peach Kiss Moisture Matte Long Wear Lipstick – '\
        'Peaches and Cream Collection - Too Faced',
      price: '21',
      image: 'https://sephora.com/productimages/sku/s2107993-main-hero-300.jpg',
      currency: 'USD',
      availability: true
    }

    include_examples 'Parser',
                     'sephora',
                     link,
                     parser_hash_item
  end

  context 'with regular price' do
    link = 'https://www.sephora.com/product/'\
           'thirstymud-tm-hydrating-treatment-P384782'
    parser_hash_item = {
      name: 'THIRSTYMUD™ Hydrating Treatment Mask - GLAMGLOW',
      price: '59',
      image: 'https://sephora.com/productimages/sku/s1582725-main-hero-300.jpg',
      currency: 'USD',
      availability: true
    }

    include_examples 'Parser',
                     'sephora_regular_price',
                     link,
                     parser_hash_item
  end
end
