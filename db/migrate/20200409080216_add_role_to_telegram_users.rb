# frozen_string_literal: true

class AddRoleToTelegramUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :telegram_users, :role, :integer, default: 0, null: false
  end
end
