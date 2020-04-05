# frozen_string_literal: true

class AddPathToLinks < ActiveRecord::Migration[6.0]
  def change
    add_column :links, :path, :string
  end
end
