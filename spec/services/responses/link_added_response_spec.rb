# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Responses::LinkAddedResponse do
  it 'makes telegram response in right shape' do
    inline_keyboard_markup = described_class.call(
      build(:link),
      build(:telegram_user)
    )

    expect(inline_keyboard_markup.keys).to match(%i[text reply_markup])
  end
end
