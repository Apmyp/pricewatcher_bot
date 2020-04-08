# frozen_string_literal: true

class AddRequestsCountErrorsCountToLinks < ActiveRecord::Migration[6.0]
  def self.up
    add_column :links, :errors_count, :integer, null: false, default: 0
  end

  def self.down
    remove_column :links, :errors_count
  end
end
