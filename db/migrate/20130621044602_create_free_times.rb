class CreateFreeTimes < ActiveRecord::Migration
  def change
    create_table :free_times do |t|
      t.date :free_date
      t.datetime :start_time
      t.datetime :end_time
      t.references :user
      t.references :crush
    end
  end
end
