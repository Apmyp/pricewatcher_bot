require 'rails_helper'

RSpec.describe Telegram::MakeIkForCreateLink do
  it 'makes keyboard in right shape' do
    inline_keyboard_markup = described_class.call

    expect(inline_keyboard_markup.keys).to match(['text', 'callback_data'])
  end
end
