# frozen_string_literal: true

class CreateTelegramUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :telegram_users do |t|
      t.integer :external_id
      t.string :first_name
      t.string :username
      t.string :language_code
      t.jsonb :raw_data
      t.integer :status, default: 0, null: false
      t.boolean :subscribed, default: false, null: false

      t.timestamps
    end
    add_index :telegram_users, :external_id
  end
end
