require 'rails_helper'

RSpec.describe Telegram::MakeIkForDeleteLink do
  it 'makes keyboard in right shape' do
    inline_keyboard_markup = described_class.call(create(:link))

    expect(inline_keyboard_markup.keys).to match(['text', 'callback_data'])
  end
end
