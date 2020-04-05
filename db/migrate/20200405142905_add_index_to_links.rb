# frozen_string_literal: true

class AddIndexToLinks < ActiveRecord::Migration[6.0]
  def change
    add_index :links, %i[telegram_user_id link], unique: true
  end
end
