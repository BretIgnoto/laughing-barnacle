class CreateLenders < ActiveRecord::Migration
  def change
    create_table :lenders do |t|
      t.integer :money

      t.timestamps null: false
    end
  end
end
