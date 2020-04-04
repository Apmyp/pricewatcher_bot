# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LinkItem, type: :model do
  it 'has factory' do
    expect(create(:link_item)).to be_persisted
  end
end
