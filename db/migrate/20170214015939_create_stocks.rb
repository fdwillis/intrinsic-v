class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      
      t.float :old_bv, default: 0
      t.float :bv_years, default: 0

      t.boolean :admin_only
      t.boolean :admin_fav

      t.timestamps null: false
    end
  end
end
