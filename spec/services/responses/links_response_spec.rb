# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Responses::LinksResponse do
  it '' do
    inline_keyboard_markup = described_class.call(build(:telegram_user))

    expect(inline_keyboard_markup.keys).to match(%i[text reply_markup])
  end
end
