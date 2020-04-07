# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Responses::LinkResponse do
  it 'makes telegram response in right shape' do
    inline_keyboard = described_class.call(
        build(:link),
        build(:telegram_user)
    )

    expect(inline_keyboard.keys).to(
        match(%i[text parse_mode reply_markup])
    )
  end
end
