# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::ParserChooser do
  shared_examples 'Host checker' do |host, path, parser_const|
    describe "Host #{host}" do
      let(:link) do
        create(:link,
               host: host,
               path: path)
      end

      it 'returns parser constant' do
        expect(described_class.call(link)).to eq(parser_const)
      end

      it 'raises an exception' do
        link.update(path: '/contact')

        expect { described_class.call(link) }.to(
          raise_error(Parsers::ParserChooser::ParserNotFoundException)
        )
      end
    end
  end

  describe 'Host dummy.com' do
    let(:link) { create(:link, :skip_validate, host: 'dummy.com', path: '') }

    it 'raises an exception for dummy host' do
      expect { described_class.call(link) }.to(
        raise_error(Parsers::ParserChooser::ParserNotFoundException)
      )
    end
  end

  include_examples 'Host checker',
                   'pumamoldova.md',
                   '/ru/shop/1/1/1/1',
                   Parsers::PumaMoldovaParser

  include_examples 'Host checker',
                   'origin.md',
                   '/ru/product/tufli-clarks-batcombe-wing-burgundy-leather',
                   Parsers::OriginParser

  include_examples 'Host checker',
                   'myskin.md',
                   '/ru/product/966-SOME-BY-ME-'\
                   '%D0%92%D0%BE%D1%81%D1%81%D1%82%D0'\
                   '%B0%D0%BD%D0%B0%D0%B2%D0%BB%D0%B8%'\
                   'D0%B2%D0%B0%D1%8E%D1%89%D0%B8%D0%B9-'\
                   '%D0%BA%D1%80%D0%B5%D0%BC-%D0%B4%D0%BB%D1%8F-'\
                   '%D0%BF%D1%80%D0%BE%D0%B1%D0%BB%D0%B5%D0%BC%D'\
                   '0%BD%D0%BE%D0%B9-%D0%BA%D0%BE%D0%B6%D0%B8-'\
                   '60%D0%BC%D0%BB',
                   Parsers::MyskinParser

  include_examples 'Host checker',
                   'moonglow.md',
                   '/ro/products/dr-ceuracle-deesse-ac-spot-healer',
                   Parsers::MoonglowParser

  include_examples 'Host checker',
                   'inglot.md',
                   '/ro/face-makeup-highlighting/979-highlighter-empowerpuff',
                   Parsers::InglotParser

  include_examples 'Host checker',
                   'elefant.md',
                   '/la-cinci-pasi-de-tine_45553530-ecaa-'\
                   '45a5-84bd-b54ac0272472',
                   Parsers::ElefantParser

  include_examples 'Host checker',
                   'sephora.com',
                   '/product/mini-star-eyeshadow-palette-'\
                   'P436273?icid2=similar%20products:p436273:product',
                   Parsers::SephoraParser

  include_examples 'Host checker',
                   'cosmeticshop.md',
                   'http://cosmeticshop.md/ru/home/'\
                   '2501-gubnaya-pomada-uvlazhnyayusshaya-dlya-gub-sophi-.html',
                   Parsers::CosmeticshopParser
end
