class CreateAuthorizations < ActiveRecord::Migration
  def change
    create_table :authorizations do |t|
      t.text :auth_type
      t.text :access_token
      t.text :refresh_token
      t.references :user
      t.timestamps
    end
    add_index(:authorizations, [:auth_type, :user_id], unique: true)
  end
end
