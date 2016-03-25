class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :fname
      t.string :lname
      t.string :email
      t.string :password_digest
      t.integer :userable_id
      t.string :userable_type

      t.timestamps null: false
    end
  end
end
