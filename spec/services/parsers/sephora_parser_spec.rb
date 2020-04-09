# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::SephoraParser do
  let!(:page_content) do
    file = "#{File.dirname(__FILE__)}/sephora_parser.txt"
    File.open(file).read
  end

  let(:raw_link) do
    'https://www.sephora.com/product/peach-kiss-moisture-matte-long-wear-lipstick-peaches-cream-collection-P422600?skuId=2108157&icid2=products%20grid:p422600'
  end

  before(:each) do
    stub_request(:get, raw_link)
      .to_return(body: page_content)
  end

  it 'extracts item struct' do
    parser_item = described_class.call(raw_link)

    expect(parser_item).to be_instance_of(Parsers::ParserItem)
    name = 'Peach Kiss Moisture Matte Long Wear Lipstick – '\
           'Peaches and Cream Collection - Too Faced'
    expect(parser_item.name).to eq(name)
    expect(parser_item.price).to eq('21')
  end
end
