class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.text :g_access_token
      t.text :g_refresh_token
      t.references :user
      t.timestamps
    end
  end
end
