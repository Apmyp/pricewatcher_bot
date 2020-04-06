# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::MoonglowParser do
  let!(:page_content) do
    file = "#{File.dirname(__FILE__)}/moonglow_parser.txt"
    File.open(file).read
  end

  let(:raw_link) do
    # rubocop:disable Layout/LineLength
    'https://moonglow.md/ro/products/dr-ceuracle-deesse-ac-spot-healer'
    # rubocop:enable Layout/LineLength
  end

  before(:each) do
    stub_request(:get, raw_link)
      .to_return(body: page_content)
  end

  it 'extracts item struct' do
    parser_item = described_class.call(raw_link)

    expect(parser_item).to be_instance_of(Parsers::ParserItem)
    expect(parser_item.name).to eq('DR.CEURACLE DÉESSE AC SPOT HEALER')
    expect(parser_item.price).to eq('495')
  end
end
