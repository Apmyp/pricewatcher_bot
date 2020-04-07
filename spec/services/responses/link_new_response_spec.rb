# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Responses::LinkNewResponse do
  it 'makes telegram response in right shape' do
    link_items = [
      create(:link_item, status: :active),
      create(:link_item, status: :pending)
    ]
    inline_keyboard_markup = described_class.call(
      create(:link, link_items: link_items),
      build(:telegram_user)
    )

    expect(inline_keyboard_markup.keys).to(
      match(%i[photo caption reply_markup parse_mode])
    )
  end
end
