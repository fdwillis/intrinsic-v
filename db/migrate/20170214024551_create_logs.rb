class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.string :symbol
      t.integer :price
      t.integer :equity
      t.integer :shares
      t.integer :net_income
      t.belongs_to :stock, index: true, foreign_key: true
      t.string :month
      t.string :day
      t.string :year
      t.string :quarter

      t.timestamps null: false
    end
  end
end
