require 'rails_helper'

RSpec.describe Telegram::MakeMessageForUpdatedLink do
  context 'link with one item' do
    let(:link) { create(:link) }

    it 'returns string' do
      message = described_class.call(link)

      expect(message).to be_acts_like_string
    end
  end

  context 'link with two items' do
    let(:link_items) { [
        create(:link_item, status: :active),
        create(:link_item, status: :pending)
    ] }

    let(:link) { create(:link, link_items: link_items) }

    it 'returns string' do
      message = described_class.call(link)

      expect(message).to be_acts_like_string
    end
  end
end
