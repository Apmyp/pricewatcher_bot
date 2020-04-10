# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::OvicoParser do
  link = 'https://ovico.md/ru/ga-stronger-with-you-freeze-edt'
  parser_hash_item = {
    name: 'GIORGIO ARMANI Stronger With You Freeze',
    price: '1215',
    image: 'https://ovico.md/media/catalog/product/cache/'\
           '1/image/300x300/9df78eab33525d08d6e5fb8d27136e95'\
           '/g/i/giorgio_armani_emporio_armani_stronger_with_you'\
           '_freeze_m_001_2.jpg',
    currency: 'MDL',
    availability: true
  }

  include_examples 'Parser',
                   'ovico',
                   link,
                   parser_hash_item
end
