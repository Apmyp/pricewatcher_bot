# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::ElefantParser do
  let!(:page_content) do
    file = "#{File.dirname(__FILE__)}/elefant_parser.txt"
    File.open(file).read
  end

  let(:raw_link) do
    'https://www.elefant.md/la-cinci-pasi-de-tine_45553530-ecaa-45a5-84bd-b54ac0272472'
  end

  before(:each) do
    stub_request(:get, raw_link)
      .to_return(body: page_content)
  end

  it 'extracts item struct' do
    parser_item = described_class.call(raw_link)

    expect(parser_item).to be_instance_of(Parsers::ParserItem)
    name = 'Rachael Lippincott, Mikki Daughtry, Tobias Iaconis'
    expect(parser_item.name).to eq(name)
    expect(parser_item.price).to eq('140.99')
  end
end
