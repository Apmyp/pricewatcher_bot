class CreateLinkItems < ActiveRecord::Migration[6.0]
  def change
    create_table :link_items do |t|
      t.belongs_to :link, null: false, foreign_key: true
      t.string :name
      t.string :image
      t.decimal :price, precision: 10, scale: 2
      t.string :currency
      t.boolean :availability, default: false, null: false
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
