class CreateThings < ActiveRecord::Migration[5.2]
  def change
    create_table :things do |t|
      t.string :name, null: false
      t.text :description
      t.boolean :visible, null: false, default: false
      t.references :user, foreign_key: true
      t.references :borrower, index: true

      t.timestamps
    end
  end
end
