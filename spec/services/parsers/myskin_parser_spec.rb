# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::MyskinParser do
  link = 'https://myskin.md/ru/product/966-SOME-BY-ME-%D0%92%D0%BE%D1%81%D1%81%D1%82%D0%B0'\
         '%D0%BD%D0%B0%D0%B2%D0%BB%D0%B8%D0%B2%D0%B0%D1%8E%D1%89%D0%B8%D0%B9-'\
         '%D0%BA%D1%80%D0%B5%D0%BC-%D0%B4%D0%BB%D1%8F-%D0%BF%D1%80%D0%BE%D0%B1'\
         '%D0%BB%D0%B5%D0%BC%D0%BD%D0%BE%D0%B9-%D0%BA%D0%BE%D0%B6%D0%B8-60'\
         '%D0%BC%D0%BB'
  parser_hash_item = {
    name: 'SOME BY ME Восстанавливающий крем для проблемной кожи, 60мл.',
    price: '315'
  }

  include_examples 'Parser',
                   'myskin',
                   link,
                   parser_hash_item
end
