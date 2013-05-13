class AddPriorityToRequest < ActiveRecord::Migration
  def change
    add_column :requests, :priority, :integer
  end
end
