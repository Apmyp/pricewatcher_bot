# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Parsers::ParserChooser do
  describe 'Host example.com' do
    let(:link) { create(:link, host: 'example.com') }

    it 'raises an exception for dummy host' do
      expect { described_class.call(link) }.to(
        raise_error(Parsers::ParserChooser::ParserNotFoundException)
      )
    end
  end

  describe 'Host pumamoldova.md' do
    let(:link) { create(:link, host: 'pumamoldova.md') }

    it 'returns pumamoldova parser constant' do
      link.update(path: '/ru/shop/1/1/1/1')
      expect(described_class.call(link)).to eq(Parsers::PumaMoldovaParser)
    end

    it 'raises an exception' do
      link.update(path: '/contact')

      expect { described_class.call(link) }.to(
          raise_error(Parsers::ParserChooser::ParserNotFoundException)
      )
    end
  end
end
