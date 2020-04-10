# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::InglotParser do
  link = 'https://inglot.md/ro/face-makeup-highlighting/979-highlighter-empowerpuff'
  parser_hash_item = {
    name: 'Highlighter Empowerpuff',
    price: '270'
  }

  include_examples 'Parser',
                   'inglot',
                   link,
                   parser_hash_item
end
