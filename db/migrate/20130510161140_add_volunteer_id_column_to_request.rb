class AddVolunteerIdColumnToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :volunteer_id, :integer
  end
end
