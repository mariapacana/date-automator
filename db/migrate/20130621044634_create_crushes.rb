class CreateCrushes < ActiveRecord::Migration
  def change
    create_table :crushes do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.string :status
      t.references :user
    end
  end
end
