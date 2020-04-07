# frozen_string_literal: true

class AddActiveLinksCountToTelegramUsers < ActiveRecord::Migration[6.0]
  def self.up
    add_column :telegram_users, :active_links_count, :integer,
               null: false, default: 0
    add_column :telegram_users, :links_count, :integer,
               null: false, default: 0
  end

  def self.down
    remove_column :telegram_users, :active_links_count
    remove_column :telegram_users, :links_count
  end
end
