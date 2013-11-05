class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.text :type
      t.text :access_token
      t.text :refresh_token
      t.references :user
      t.timestamps
    end
  end
end
