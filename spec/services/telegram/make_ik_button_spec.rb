# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Telegram::MakeIkButton do
  it 'makes keyboard in right shape' do
    inline_keyboard_markup = described_class.call(text: '', action: '')

    expect(inline_keyboard_markup.keys).to match(%w[text callback_data])
  end
end
