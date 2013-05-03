class CreateCandidateCircleLinkTable < ActiveRecord::Migration
  def change
    create_table :candidates_circles, :id => false do |t|
      t.integer :candidate_id
      t.integer :circle_id
    end
  end
end
