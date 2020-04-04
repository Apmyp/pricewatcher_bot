# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Links::CreateLink do
  let(:user) { create(:telegram_user) }

  it 'creates link with host and scheme in the right way' do
    link = described_class.call(user, 'https://example.com/path')

    expect(link).to be_persisted
    expect(link.link).to eq('https://example.com/path')
    expect(link.host).to eq('example.com')
    expect(link.scheme).to eq('https')
  end

  it 'creates link without scheme' do
    link = described_class.call(user, 'example.com/path')

    expect(link).to be_persisted
    expect(link.link).to eq('http://example.com/path')
    expect(link.host).to eq('example.com')
    expect(link.scheme).to eq('http')
  end

  it 'creates link without scheme, but with //' do
    link = described_class.call(user, '//example.com/path')

    expect(link).to be_persisted
    expect(link.link).to eq('http://example.com/path')
    expect(link.host).to eq('example.com')
    expect(link.scheme).to eq('http')
  end

  it 'creates link without scheme with www' do
    link = described_class.call(user, 'www.example.com/path')

    expect(link).to be_persisted
    expect(link.link).to eq('http://www.example.com/path')
    expect(link.host).to eq('example.com')
    expect(link.scheme).to eq('http')
  end

  it 'creates link with www' do
    link = described_class.call(user, 'https://www.example.com/path')

    expect(link).to be_persisted
    expect(link.link).to eq('https://www.example.com/path')
    expect(link.host).to eq('example.com')
    expect(link.scheme).to eq('https')
  end
end
