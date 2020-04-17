# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::ParserChooser do
  shared_examples 'Host checker' do |raw_link, parser_const|
    host = URI.parse(raw_link).host
    describe "Host #{host}" do
      let(:user) { create(:telegram_user) }

      let(:link) do
        Links::CreateLink.call(user, raw_link)
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
                   'https://pumamoldova.md/ru/shop/1/1/1/1',
                   Parsers::PumaMoldovaParser

  include_examples 'Host checker',
                   'https://origin.md/ru/product/'\
                   'tufli-clarks-batcombe-wing-burgundy-leather',
                   Parsers::OriginParser

  include_examples 'Host checker',
                   'https://myskin.md/ru/product/966-SOME-BY-ME-'\
                   '%D0%92%D0%BE%D1%81%D1%81%D1%82%D0'\
                   '%B0%D0%BD%D0%B0%D0%B2%D0%BB%D0%B8%'\
                   'D0%B2%D0%B0%D1%8E%D1%89%D0%B8%D0%B9-'\
                   '%D0%BA%D1%80%D0%B5%D0%BC-%D0%B4%D0%BB%D1%8F-'\
                   '%D0%BF%D1%80%D0%BE%D0%B1%D0%BB%D0%B5%D0%BC%D'\
                   '0%BD%D0%BE%D0%B9-%D0%BA%D0%BE%D0%B6%D0%B8-'\
                   '60%D0%BC%D0%BB',
                   Parsers::MyskinParser

  include_examples 'Host checker',
                   'https://moonglow.md/ro/products/'\
                   'dr-ceuracle-deesse-ac-spot-healer',
                   Parsers::MoonglowParser

  include_examples 'Host checker',
                   'https://inglot.md/ro/face-makeup-highlighting/'\
                   '979-highlighter-empowerpuff',
                   Parsers::InglotParser

  include_examples 'Host checker',
                   'https://elefant.md/la-cinci-pasi-de-tine_45553530-ecaa-'\
                   '45a5-84bd-b54ac0272472',
                   Parsers::ElefantParser

  include_examples 'Host checker',
                   'https://sephora.com/product/mini-star-eyeshadow-palette-'\
                   'P436273?icid2=similar%20products:p436273:product',
                   Parsers::SephoraParser

  include_examples 'Host checker',
                   'http://cosmeticshop.md/ru/home/'\
                   '2501-gubnaya-pomada-uvlazhnyayusshaya-dlya-gub-sophi-.html',
                   Parsers::CosmeticshopParser

  include_examples 'Host checker',
                   'https://makeup.md/product/314655/',
                   Parsers::MakeupParser

  include_examples 'Host checker',
                   'https://makeup.md/ru/product/314655/',
                   Parsers::MakeupParser

  include_examples 'Host checker',
                   'https://ovico.md/ru/ga-stronger-with-you-freeze-edt',
                   Parsers::OvicoParser

  include_examples 'Host checker',
                   'https://shop.vizaje-nica.com/tovar/uhod-za-kozhey'\
                   '/antivozrastnyie-sredstva/l-action-youth-boosting-'\
                   'night-mask-nochnaya-maska-stimulyatsiya-molodosti',
                   Parsers::VizajenicaParser

  include_examples 'Host checker',
                   'https://www.cultbeauty.co.uk/'\
                   'huda-beauty-mercury-retrograde-palette.html',
                   Parsers::CultbeautyParser

  include_examples 'Host checker',
                   'https://www.pegas.md/ru/pages/shop/1/27/32/687/',
                   Parsers::PegasParser

  include_examples 'Host checker',
                   'https://alcomarket.md/ru/product/viski-jack-daniel-s-035l/',
                   Parsers::AlcomarketParser

  include_examples 'Host checker',
                   'https://sonycenter.md/ru/shop/wh-l600/',
                   Parsers::SonycenterParser
end
