class CreateCrushes < ActiveRecord::Migration
  def change
    create_table :crushes do |t|
      t.string :first_name
      t.string :last_name
      t.string :phone
      t.boolean :interested
      t.boolean :date_scheduled
      t.references :user
    end
  end
end
