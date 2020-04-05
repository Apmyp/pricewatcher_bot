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
end
