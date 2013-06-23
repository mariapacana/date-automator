class CreateFreeTimes < ActiveRecord::Migration
  def change
    create_table :free_times do |t|
      t.datetime :start_time
      t.references :user
      t.references :crush
    end
  end
end
