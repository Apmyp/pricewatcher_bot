require 'rails_helper'

RSpec.describe Links::CreateLink do
  let(:user) { create(:telegram_user) }
  let(:raw_link) { "https://example.com" }

  it "creates link with host and scheme in the right way" do
    link = described_class.call(user, raw_link)

    expect(link).to be_persisted
    expect(link.host).to eq('example.com')
    expect(link.scheme).to eq('https')
  end
end
