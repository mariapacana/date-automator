class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.text :request_text
      t.text :response_text
      t.integer :pin
      t.references :user
      t.references :phone
      t.timestamps
    end
  end
end
