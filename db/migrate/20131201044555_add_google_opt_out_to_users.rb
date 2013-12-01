class AddGoogleOptOutToUsers < ActiveRecord::Migration
  def change
    add_column(:users, :google_opt_out, :boolean)
  end
end
