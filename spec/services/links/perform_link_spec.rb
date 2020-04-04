# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::PerformLink do
  let(:link) { create(:link) }
  let(:parser_item) { build(:parser_item, price: '1330') }

  describe 'without link item' do
    it 'creates link with host and scheme in the right way' do
      expect(Links::AttachLinkItem).to receive(:call)
        .with(link, parser_item)
        .and_return(link.active_link_item)

      dbl = double
      allow(dbl).to receive(:call).with(link.link).and_return(parser_item)

      expect(Parsers::ParserChooser).to receive(:call).with(link).and_return(dbl)

      expect(described_class.call(link)).to eq([link.active_link_item, nil])
    end
  end

  describe 'with link item and the different price' do
    let!(:link_item) { create(:link_item, link: link, price: '2500') }

    it 'creates link with host and scheme in the right way' do
      expect(Links::AttachLinkItem).to receive(:call)
        .with(link, parser_item)
        .and_return(link_item)

      dbl = double
      allow(dbl).to receive(:call).with(link.link).and_return(parser_item)

      expect(Parsers::ParserChooser).to receive(:call).with(link).and_return(dbl)

      expect(described_class.call(link)).to eq([link.active_link_item, { price: '1330' }])
    end
  end

  describe 'with link item and same price' do
    let!(:link_item) { create(:link_item, link: link, price: '1330') }

    it 'creates link with host and scheme in the right way' do
      expect(Links::AttachLinkItem).to_not receive(:call).with(link, parser_item)

      dbl = double
      allow(dbl).to receive(:call).with(link.link).and_return(parser_item)

      expect(Parsers::ParserChooser).to receive(:call).with(link).and_return(dbl)

      expect(described_class.call(link)).to eq([nil, nil])
    end
  end
end
