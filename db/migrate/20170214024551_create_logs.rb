class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :price, default: 0
      t.integer :equity, default: 0
      t.integer :shares, default: 0
      t.integer :net_income, default: 0
      t.integer :month
      t.integer :day
      t.integer :bv, default: 0
      t.integer :year

      t.string :quarter
      
      t.float :coupon, default: 0

      t.belongs_to :stock, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
