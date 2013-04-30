class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.integer :user_id
      t.date :date
      t.string :start_time
      t.string :end_time

      t.timestamps
    end
  end
end
