require 'rails_helper'

RSpec.describe Links::AttachLinkItem do
  let(:link) { create(:link) }
  let(:parser_item) { build(:parser_item, price: "1330") }
  let(:second_parser_item) { build(:parser_item, price: "1270") }

  it "attaches one more link item" do
    expect { described_class.call(link, parser_item) }
        .to change { link.link_items.count }.by(1)
  end

  it "attaches one more link item" do
    described_class.call(link, parser_item)

    second_link_item = described_class.call(link, second_parser_item)

    active_item_ids = LinkItem.where(link: link, status: :active).pluck(:id)
    expect(active_item_ids).to eq([second_link_item.id])
  end
end
