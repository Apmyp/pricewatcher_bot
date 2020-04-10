# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::CultbeautyParser do
  link = 'https://www.cultbeauty.co.uk/'\
         'huda-beauty-mercury-retrograde-palette.html'
  parser_hash_item = {
    name: 'Mercury Retrograde Palette by Huda Beauty',
    price: '58',
    image: 'https://d10qoa1dy3vloz.cloudfront.net/slots-img/'\
           'hudhud000_hudabeauty_mercuryretrograde_2_1560x1960-xhyc4jpg',
    currency: 'GBP',
    availability: true
  }

  include_examples 'Parser',
                   'cultbeauty',
                   link,
                   parser_hash_item
end
