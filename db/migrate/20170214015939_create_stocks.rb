class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.integer :equity
      t.float :price
      t.integer :shares
      t.boolean :admin_only
      t.boolean :admin_fav
      t.integer :net_income
      t.string :quarter

      t.timestamps null: false
    end
  end
end
