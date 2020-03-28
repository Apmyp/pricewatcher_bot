class Link < ApplicationRecord
  enum status: %i[active disabled]
end
