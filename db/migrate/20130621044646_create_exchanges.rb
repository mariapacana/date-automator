class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.text :request_text
      t.text :response_text
      t.string :type
      t.references :user
      t.references :crush
      t.timestamps
    end
  end
end
