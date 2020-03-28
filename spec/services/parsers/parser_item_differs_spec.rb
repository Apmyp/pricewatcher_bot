require 'rails_helper'

RSpec.describe Parsers::ParserItemDiffers do
  describe "Different parser items" do
    let(:parser_item) { build(:parser_item, price: "1330") }
    let(:second_parser_item) { build(:parser_item, price: "2550") }

    it "raises an exception for dummy host" do
      described_class.call(parser_item, second_parser_item)
    end
  end

  describe "The same parser items" do
    let(:parser_item) { build(:parser_item, price: "1330") }
    let(:second_parser_item) { build(:parser_item, price: "1330") }

    it "raises an exception for dummy host" do
      described_class.call(parser_item, second_parser_item)
    end
  end
end
