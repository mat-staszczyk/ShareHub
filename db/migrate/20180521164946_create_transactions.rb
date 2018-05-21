class CreateTransactions < ActiveRecord::Migration[5.2]
  def change
    create_table :transactions do |t|
      t.string :name
      t.text :notes
      t.references :lender, index: true
      t.references :borrower, index: true
      t.references :thing, foreign_key: true
      t.datetime :borrowed_at
      t.datetime :returned_at
      t.date :planned_return_on

      t.timestamps
    end
  end
end
