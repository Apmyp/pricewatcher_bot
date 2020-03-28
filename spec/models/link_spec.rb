require 'rails_helper'

RSpec.describe Link, type: :model do
  it 'has factory' do
    expect(create(:link)).to be_persisted
  end
end
