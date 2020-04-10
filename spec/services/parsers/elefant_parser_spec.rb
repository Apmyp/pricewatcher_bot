# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::ElefantParser do
  link = 'https://www.elefant.md/la-cinci-pasi-de-tine_45553530-ecaa-45a5-84bd-b54ac0272472'
  parser_hash_item = {
    name: 'Rachael Lippincott, Mikki Daughtry, Tobias Iaconis',
    price: '140',
    image: 'http://mcdn.elefant.ro/mnresize/1500/1500/images/08/2001908/'\
           'la-cinci-pasi-de-tine_1_fullsize.jpg',
    currency: 'MDL',
    availability: true
  }

  include_examples 'Parser',
                   'elefant',
                   link,
                   parser_hash_item
end
