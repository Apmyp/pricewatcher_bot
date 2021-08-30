# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::DarwinParser do
  context 'with sale' do
    link = 'https://darwin.md/ru/smartphone_Apple-iPhone-11-Pro-512GB-Gold.html'
    parser_hash_item = {
      name: 'Apple iPhone 12 Pro Max 128GB, Pacific Blue cumpara pe Darwin.md',
      price: '24999',
      image: 'https://darwin.md/images/product/2020/11/iphone_12_pro_max_pacific_blue1-201116024211-darwin.png',
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
      name: 'Samsung Galaxy Z Flip 3 8 GB  256 GB Green vezi pe Darwin.md',
      price: '22599',
      image: 'https://darwin.md/images/product/2021/08/darwin-samsung-galaxy-z-flip-3-8-gb-256-gb-green-019.png',
      currency: 'MDL',
      availability: true
    }

    include_examples 'Parser',
                     'darwin_without_sale',
                     link,
                     parser_hash_item
  end
end
