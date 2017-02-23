class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      t.float :equity, default: 0
      t.float :price, default: 0
      t.float :shares, default: 0
      t.float :coupon, default: 0
      t.float :old_bv, default: 0
      t.float :bv_years, default: 0
      t.boolean :admin_only
      t.boolean :admin_fav
      t.float :net_income, default: 0
      t.string :quarter
      t.string :quarter_year

      t.timestamps null: false
    end
  end
end
