# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Request, type: :model do
  it 'has factory' do
    expect(create(:request)).to be_persisted
  end
end
