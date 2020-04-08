# frozen_string_literal: true

class CreateRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :requests do |t|
      t.integer :status, default: 0, null: false
      t.string :html
      t.belongs_to :link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
