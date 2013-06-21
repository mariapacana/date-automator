class CreateExchanges < ActiveRecord::Migration
  def change
    create_table :exchanges do |t|
      t.text :sent_text
      t.text :response_text
      t.references :user
      t.references :crush
    end
  end
end
