# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::PumaMoldovaParser do
  let(:raw_link) { 'http://pumamoldova.md/ru/shop/male/footwear/lifestyle/370846-05' }

  before(:each) do
    stub_request(:get, raw_link)
      .to_return(body: '
<meta property="og:title" content="Кроссовки Puma Ralph Sampson Lo">
<meta property="og:image" content="http://pumamoldova.md/images/products/jpg/37084605.jpg">
<meta property="product:brand" content="Puma">
<meta property="product:availability" content="in stock">
<meta property="product:price:amount" content="1199">
<meta property="product:retailer_item_id" content="370846-05">
<meta property="product:price:currency" content="MDL">
<meta property="product_type" content="Мужчины > Обувь>Лайфстайл > Лайфстайл"/>
')
  end

  it 'extracts item struct from pumamoldova page' do
    parser_item = described_class.call(raw_link)

    expect(parser_item).to be_instance_of(Parsers::ParserItem)
    expect(parser_item.name).to eq('Кроссовки Puma Ralph Sampson Lo')
  end
end
