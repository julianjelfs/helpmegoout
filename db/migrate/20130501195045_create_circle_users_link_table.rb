class CreateCircleUsersLinkTable < ActiveRecord::Migration
  def change
    create_table :circles_users, :id => false do |t|
      t.integer :circle_id
      t.integer :user_id
    end
  end
end
