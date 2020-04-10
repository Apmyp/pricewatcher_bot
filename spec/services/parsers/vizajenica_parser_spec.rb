# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::VizajenicaParser do
  link = 'https://shop.vizaje-nica.com/tovar/uhod-za-kozhey/'\
         'antivozrastnyie-sredstva/l-action-youth-boosting-night-'\
         'mask-nochnaya-maska-stimulyatsiya-molodosti'
  parser_hash_item = {
    name: 'L’Action Youth-Boosting Night Mask '\
          'Ночная маска «Стимуляция молодости»',
    price: '40',
    image: 'https://shop.vizaje-nica.com/wp-content/uploads/vignette3-4NJEUN.jpg',
    currency: 'MDL',
    availability: true
  }

  include_examples 'Parser',
                   'vizajenica',
                   link,
                   parser_hash_item
end
