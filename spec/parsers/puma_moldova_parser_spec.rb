require 'rails_helper'

RSpec.describe PumaMoldovaParser do
  let(:url) { "http://pumamoldova.md/ru/shop/male/footwear/lifestyle/370846-05" }

  before(:each) do
    stub_request(:get, url).
        to_return(body: '
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

  it "parses" do
    parser_item = subject.call(url)

    expect(parser_item).to be_instance_of(ParserItem)
    expect(parser_item.name).to eq('Кроссовки Puma Ralph Sampson Lo')
  end
end
