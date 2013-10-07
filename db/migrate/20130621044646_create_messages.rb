class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.text :body
      t.boolean :from_user
      t.references :user
      t.references :crush
      t.timestamps
    end
  end
end
