# frozen_string_literal: true

class Request < ApplicationRecord
  enum status: { success: 0, error: 1 }

  belongs_to :link, inverse_of: :requests
  counter_culture :link,
                  column_name: proc { |m| m.error? ? 'errors_count' : nil }
end
