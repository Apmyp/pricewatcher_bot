# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::PerformLink do
  let(:link) { create(:link) }
  let(:parser_item) { build(:parser_item, price: '1330') }

  let(:parser_dbl) do
    parser_dbl = double
    allow(parser_dbl).to receive(:to_html)
    parser_dbl
  end

  let(:parser_const_dbl) do
    parser_const_dbl = double
    allow(parser_const_dbl).to(
      receive(:new).with(link.link).and_return(parser_dbl)
    )
    parser_const_dbl
  end

  before :each do
    expect(Parsers::ParserChooser).to(
      receive(:call).with(link).and_return(parser_const_dbl)
    )
  end

  context 'parser works with errors' do
    shared_examples 'Parser raises error' do |error_const|
      it "saves error request while #{error_const}" do
        allow(parser_dbl).to receive(:call).and_raise(error_const)
        allow(parser_dbl).to receive(:to_html).and_return('test')

        expect(Links::CreateLinkRequest).to receive(:call).with(
          link: link,
          status: :error,
          html: 'test'
        ).and_return(Request.new)

        expect { described_class.call(link) }.to raise_error(error_const)
      end
    end

    include_examples 'Parser raises error', Dry::Struct::Error
    include_examples 'Parser raises error', Parsers::NotOkException
    include_examples 'Parser raises error',
                     Parsers::ParserChooser::ParserNotFoundException

    it 'disables link when 3 errors occured' do
      create_list(:request, 3, link: link, status: :error)
      allow(parser_dbl).to receive(:call).and_raise(Dry::Struct::Error)
      allow(parser_dbl).to receive(:to_html).and_return('test')

      expect(Links::DisableLink).to(
        receive(:call).with(link)
      )

      expect { described_class.call(link) }.to raise_error(Dry::Struct::Error)
    end
  end

  context 'parser works good' do
    before(:each) do
      allow(parser_dbl).to receive(:call).and_return(parser_item)
    end

    describe 'without link item' do
      it 'creates link_item without diff' do
        expect(Links::AttachLinkItem).to(
          receive(:call)
              .with(link, parser_item)
              .and_return(link.active_link_item)
        )

        expect(described_class.call(link)).to eq([link.active_link_item, nil])
      end
    end

    describe 'with link item and the different price' do
      let!(:link_item) { create(:link_item, link: link, price: '2500') }

      it 'returns link_item with diff' do
        expect(Links::AttachLinkItem).to(
          receive(:call).with(link, parser_item).and_return(link_item)
        )

        expect(described_class.call(link)).to(
          eq([link.active_link_item, { price: '1330' }])
        )
      end
    end

    describe 'with link item and same price' do
      let!(:link_item) { create(:link_item, link: link, price: '1330') }

      it 'not create anything' do
        expect(Links::AttachLinkItem).to_not(
          receive(:call).with(link, parser_item)
        )

        expect(described_class.call(link)).to(
          eq([nil, nil])
        )
      end
    end
  end
end
