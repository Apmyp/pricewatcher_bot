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
      expect(described_class.call(link)).to eq(Parsers::PumaMoldovaParser)
    end
  end
end
