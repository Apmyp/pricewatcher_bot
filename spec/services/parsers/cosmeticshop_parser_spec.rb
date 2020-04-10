# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::CosmeticshopParser do
  link = 'http://cosmeticshop.md/ru/home/'\
         '2501-gubnaya-pomada-uvlazhnyayusshaya-dlya-gub-sophi-.html'
  parser_hash_item = {
    name: 'Губная помада увлажняющая для губ SOPHI',
    price: '63',
    image: 'http://cosmeticshop.md/5881-large_default'\
           '/gubnaya-pomada-uvlazhnyayusshaya-dlya-gub-sophi-.jpg',
    currency: 'MDL',
    availability: true
  }

  include_examples 'Parser',
                   'cosmeticshop',
                   link,
                   parser_hash_item
end
