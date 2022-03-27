class CreateLogs < ActiveRecord::Migration
  def change
    create_table :logs do |t|
      t.integer :price, null: false #ask
      t.integer :equity, null: false
      t.integer :shares, null: false
      t.integer :net_income, null: false
      t.integer :bv, null: false
      t.integer :year

      t.string :quarter
      t.string :uuid, default: SecureRandom.uuid[0..7]
      
      t.float :coupon, null: false

      t.belongs_to :stock, index: true, foreign_key: true
      # t.belongs_to :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
