class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :password_hash
      t.timestamps
    end
    add_index(:users, [:email, :phone], unique: true)
  end
end
