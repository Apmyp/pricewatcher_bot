class ParserItem < Dry::Struct
  schema schema.strict

  attribute :name, Types::String
  attribute :image, Types::String
  attribute :price, Types::Integer
  attribute :currency, Types::String
  attribute :availability, Types::Strict::Bool
end