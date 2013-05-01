class CreateCircleRequestsLinkTable < ActiveRecord::Migration
  def change
    create_table :circles_requests, :id => false do |t|
      t.integer :circle_id
      t.integer :request_id
    end
  end
end
