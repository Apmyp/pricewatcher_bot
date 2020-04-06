# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::ParserChooser do
  describe 'Host dummy.com' do
    let(:link) { create(:link, :skip_validate, host: 'dummy.com', path: '') }

    it 'raises an exception for dummy host' do
      expect { described_class.call(link) }.to(
        raise_error(Parsers::ParserChooser::ParserNotFoundException)
      )
    end
  end

  describe 'Host pumamoldova.md' do
    let(:link) do
      create(:link,
             host: 'pumamoldova.md',
             path: '/ru/shop/1/1/1/1')
    end

    it 'returns pumamoldova parser constant' do
      expect(described_class.call(link)).to eq(Parsers::PumaMoldovaParser)
    end

    it 'raises an exception' do
      link.update(path: '/contact')

      expect { described_class.call(link) }.to(
        raise_error(Parsers::ParserChooser::ParserNotFoundException)
      )
    end
  end

  describe 'Host origin.md' do
    let(:link) do
      create(:link,
             host: 'origin.md',
             path: '/ru/product/tufli-clarks-batcombe-wing-burgundy-leather')
    end

    it 'returns parser constant' do
      expect(described_class.call(link)).to eq(Parsers::OriginParser)
    end

    it 'raises an exception' do
      link.update(path: '/contact')

      expect { described_class.call(link) }.to(
        raise_error(Parsers::ParserChooser::ParserNotFoundException)
      )
    end
  end

  describe 'Host myskin.md' do
    let(:link) do
      # rubocop:disable Layout/LineLength
      create(:link,
             host: 'myskin.md',
             path: '/ru/product/966-SOME-BY-ME-%D0%92%D0%BE%D1%81%D1%81%D1%82%D0%B0%D0%BD%D0%B0%D0%B2%D0%BB%D0%B8%D0%B2%D0%B0%D1%8E%D1%89%D0%B8%D0%B9-%D0%BA%D1%80%D0%B5%D0%BC-%D0%B4%D0%BB%D1%8F-%D0%BF%D1%80%D0%BE%D0%B1%D0%BB%D0%B5%D0%BC%D0%BD%D0%BE%D0%B9-%D0%BA%D0%BE%D0%B6%D0%B8-60%D0%BC%D0%BB')
      # rubocop:enable Layout/LineLength
    end

    it 'returns parser constant' do
      expect(described_class.call(link)).to eq(Parsers::MyskinParser)
    end

    it 'raises an exception' do
      link.update(path: '/contact')

      expect { described_class.call(link) }.to(
        raise_error(Parsers::ParserChooser::ParserNotFoundException)
      )
    end
    end

  describe 'Host moonglow.md' do
    let(:link) do
      # rubocop:disable Layout/LineLength
      create(:link,
             host: 'moonglow.md',
             path: '/ro/products/dr-ceuracle-deesse-ac-spot-healer')
      # rubocop:enable Layout/LineLength
    end

    it 'returns parser constant' do
      expect(described_class.call(link)).to eq(Parsers::MoonglowParser)
    end

    it 'raises an exception' do
      link.update(path: '/contact')

      expect { described_class.call(link) }.to(
        raise_error(Parsers::ParserChooser::ParserNotFoundException)
      )
    end
  end
end
