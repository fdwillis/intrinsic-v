class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.float :old_bv, default: 0
      t.float :bv_years, default: 0
      t.boolean :admin_only
      t.boolean :admin_fav
      # make the rest a different table
      t.float :price, default: 0
      t.float :equity, default: 0
      t.float :shares, default: 0
      t.float :coupon, default: 0
      t.float :net_income, default: 0
      t.string :quarter
      t.integer :quarter_year

      t.timestamps null: false
    end
  end
end
