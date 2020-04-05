# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::OriginParser do
  let!(:page_content) do
    file = "#{File.dirname(__FILE__)}/origin_parser.txt"
    File.open(file).read
  end

  let(:raw_link) do
    'https://origin.md/ru/product/tufli-clarks-un-larvik-lace-brown-leather'
  end

  before(:each) do
    stub_request(:get, raw_link)
      .to_return(body: page_content)
  end

  it 'extracts item struct' do
    parser_item = described_class.call(raw_link)

    expect(parser_item).to be_instance_of(Parsers::ParserItem)
    expect(parser_item.name).to eq('Туфли мужские Un Larvik Lace Brown Leather')
  end
end
