# frozen_string_literal: true

class AddTelegramUserToLinks < ActiveRecord::Migration[6.0]
  def change
    add_reference :links, :telegram_user, null: false, foreign_key: true
  end
end
