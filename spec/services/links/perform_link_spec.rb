require 'rails_helper'

RSpec.describe Links::PerformLink do
  let(:link) { create(:link) }
  let(:parser_item) { build(:parser_item, price: "1330") }

  describe "without link item" do
    it "creates link with host and scheme in the right way" do
      expect(Links::AttachLinkItem).to receive(:call).with(link, parser_item)

      dbl = double
      allow(dbl).to receive(:call).with(link.link).and_return(parser_item)

      expect(Parsers::ParserChooser).to receive(:call).with(link).and_return(dbl)


      described_class.call(link)
    end
  end

  describe "with link item and the same price" do
    let!(:link_item) { create(:link_item, link: link, price: "2500") }

    it "creates link with host and scheme in the right way" do
      expect(Links::AttachLinkItem).to receive(:call).with(link, parser_item)

      dbl = double
      allow(dbl).to receive(:call).with(link.link).and_return(parser_item)

      expect(Parsers::ParserChooser).to receive(:call).with(link).and_return(dbl)


      described_class.call(link)
    end
  end

  describe "with link item and different price" do
    let!(:link_item) { create(:link_item, link: link, price: "1330") }

    it "creates link with host and scheme in the right way" do
      expect(Links::AttachLinkItem).to_not receive(:call).with(link, parser_item)

      dbl = double
      allow(dbl).to receive(:call).with(link.link).and_return(parser_item)

      expect(Parsers::ParserChooser).to receive(:call).with(link).and_return(dbl)


      described_class.call(link)
    end
  end
end
