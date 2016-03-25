class CreateLends < ActiveRecord::Migration
  def change
    create_table :lends do |t|
      t.references :lender, index: true, foreign_key: true
      t.references :borrower, index: true, foreign_key: true
      t.integer :amount

      t.timestamps null: false
    end
  end
end
