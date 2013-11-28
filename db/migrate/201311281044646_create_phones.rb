class CreatePhones < ActiveRecord::Migration
  def change
    create_table :phones do |t|
      t.string :phone_number
      t.integer :next_pin
      t.timestamps
    end
    add_index(:phones, :phone_number, unique: true)
  end
end
