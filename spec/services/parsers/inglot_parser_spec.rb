# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::InglotParser do
  let(:raw_link) do
    'https://inglot.md/ro/face-makeup-highlighting/979-highlighter-empowerpuff'
  end

  before(:each) do
    # rubocop:disable Layout/LineLength
    stub_request(:get, raw_link)
      .to_return(body: '
<meta property="og:url" content="https://inglot.md/ro/face-makeup-highlighting/979-highlighter-empowerpuff" />
<meta property="og:title" content="Highlighter Empowerpuff" />
<meta property="og:site_name" content="Inglot Cosmetics Moldova" />
<meta property="og:description" content="" />
<meta property="og:image" content="https://inglot.md/9653-large_default/highlighter-empowerpuff.jpg" />
<meta property="product:pretax_price:amount" content="225" />
<meta property="product:pretax_price:currency" content="MDL" />
<meta property="product:price:amount" content="270" />
<meta property="product:price:currency" content="MDL" />
<meta property="product:weight:value" content="0.050000" />
<meta property="product:weight:units" content="kg" />
')
    # rubocop:enable Layout/LineLength
  end

  it 'extracts item struct' do
    parser_item = described_class.call(raw_link)

    expect(parser_item).to be_instance_of(Parsers::ParserItem)
    expect(parser_item.name).to eq('Highlighter Empowerpuff')
    expect(parser_item.price).to eq('270')
  end
end
