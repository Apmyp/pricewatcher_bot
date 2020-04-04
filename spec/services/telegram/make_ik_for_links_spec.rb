# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Telegram::MakeIkForLinks do
  let(:links) { create_list(:link, 10) }

  it 'makes keyboard in right shape' do
    ik_markup = described_class.call(links)

    expect(ik_markup.size).to eq(10)
    expect(ik_markup.first&.first&.keys).to match(%w[text callback_data])
  end
end
