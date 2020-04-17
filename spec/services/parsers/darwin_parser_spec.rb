# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::DarwinParser do
  context 'with sale' do
    link = 'https://darwin.md/ru/smartphone_Apple-iPhone-11-Pro-512GB-Gold.html'
    parser_hash_item = {
      name: 'Apple iPhone 11 Pro 512GB, Gold - iPhone Apple',
      price: '29999',
      image: 'https://darwin.md/images/product/2019/'\
           '18/darwin-apple-iphone-11-pro-512gb-gold.jpg',
      currency: 'MDL',
      availability: true
    }

    include_examples 'Parser',
                     'darwin',
                     link,
                     parser_hash_item
  end

  context 'without sale' do
    link = 'https://darwin.md/ru/samsung-rs66n8100s9ua-silver.html'
    parser_hash_item = {
      name: 'Samsung RS66N8100S9/UA, Inox - Крупная бытовая техника Samsung',
      price: '21899',
      image: 'https://darwin.md/images/product/'\
               '2020/01/1-200103054758-darwin.jpg',
      currency: 'MDL',
      availability: true
    }

    include_examples 'Parser',
                     'darwin_without_sale',
                     link,
                     parser_hash_item
  end
end
