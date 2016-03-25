class CreateBorrowers < ActiveRecord::Migration
  def change
    create_table :borrowers do |t|
      t.string :money_for
      t.text :reason
      t.integer :needed

      t.timestamps null: false
    end
  end
end
