class CreateStocks < ActiveRecord::Migration
  def change
    create_table :stocks do |t|
      t.string :symbol
      
      t.float :old_bv, null: false
      t.float :bv_years, null: false

      t.boolean :admin_only
      t.boolean :admin_fav

      t.timestamps null: false
    end
  end
end
