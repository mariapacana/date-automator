class CreateCrushes < ActiveRecord::Migration
  def change
    create_table :crushes do |t|
      t.string :first_name
      t.string :last_name
      t.string :status
      t.references :user
      t.references :phone
      t.timestamps
    end
    add_index(:crushes, [:user_id, :phone_id], unique: true)
  end
end
