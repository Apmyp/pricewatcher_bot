class CreateLinks < ActiveRecord::Migration[6.0]
  def change
    create_table :links do |t|
      t.string :link
      t.string :scheme
      t.string :host
      t.integer :status, default: 0, null: false

      t.timestamps
    end
  end
end
