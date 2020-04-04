# frozen_string_literal: true

require 'rails_helper'

RSpec.describe FindOrCreateTelegramUser do
  let(:from) do
    {
      'id' => 121_918_175,
      'is_bot' => false,
      'first_name' => 'Артур',
      'username' => 'apmyp0',
      'language_code' => 'ru'
    }
  end

  it 'creates telegram user' do
    user = described_class.call(from)

    expect(user).to be_persisted
    expect(user.external_id).to eq(121_918_175)
    expect(user.username).to eq('apmyp0')
  end
end
