require 'rails_helper'

RSpec.describe Link, type: :model do
  it 'has factory' do
    expect(create(:link)).to be_persisted
  end

  it 'displays host when no items found' do
    link = create(:link, host: 'example.com', hash_id: 'test')

    expect(link.display_name).to eq("example.com (\#test)")
  end

  it 'displays name of item when item exists' do
    link = create(:link)
    create(:link_item, link: link, name: 'Test', price: 10, currency: '$')

    expect(link.display_name).to eq("Test (10$)")
  end
end
