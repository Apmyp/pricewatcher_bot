# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Responses::LinkResponse do
  it '' do
    inline_keyboard_markup = described_class.call(build(:link), build(:telegram_user))

    expect(inline_keyboard_markup.keys).to match(%i[text parse_mode reply_markup])
  end
end
