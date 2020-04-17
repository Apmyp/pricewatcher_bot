# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::SonycenterParser do
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
