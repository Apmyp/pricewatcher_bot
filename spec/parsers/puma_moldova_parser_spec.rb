require 'rails_helper'

RSpec.describe PumaMoldovaParser do
  let(:url) { "http://pumamoldova.md/ru/shop/male/footwear/lifestyle/370846-05" }

  before(:each) do
    stub_request(:get, url).
        to_return(body: '<meta property="product:brand" content="Puma">
		<meta property="product:availability" content="in stock">
		<meta property="product:price:amount" content="1199">
		<meta property="product:retailer_item_id" content="370846-05">
		<meta property="product:price:currency" content="MDL">
		<meta property="product_type" content="Мужчины > Обувь>Лайфстайл > Лайфстайл"/>')
  end

  it "parses" do
    expect(subject.call(url)).to include("product:retailer_item_id")
  end
end
