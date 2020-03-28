module Parsers
  class ParserItem < Dry::Struct
    schema schema.strict

    attribute :name, Types::Strict::String
    attribute :image, Types::Strict::String
    attribute :price, Types::Strict::String
    attribute :currency, Types::Strict::String
    attribute :availability, Types::Strict::Bool
  end
end