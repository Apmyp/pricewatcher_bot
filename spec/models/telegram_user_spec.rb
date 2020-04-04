# frozen_string_literal: true

require 'rails_helper'

RSpec.describe TelegramUser, type: :model do
  it 'has factory' do
    expect(create(:telegram_user)).to be_persisted
  end
end
