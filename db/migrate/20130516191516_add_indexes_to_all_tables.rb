class AddIndexesToAllTables < ActiveRecord::Migration
  def change
    add_index :candidates, :email
    add_index :candidates_circles, :candidate_id
    add_index :candidates_circles, :circle_id
    add_index :circles, :owner_id
    add_index :circles_requests, :circle_id
    add_index :circles_requests, :request_id
    add_index :circles_users, :circle_id
    add_index :circles_users, :user_id
    add_index :requests, :user_id
    add_index :requests, :volunteer_id    
  end
end
