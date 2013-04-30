class CreateCirles < ActiveRecord::Migration
  def change
    create_table :cirles do |t|
      t.string :name
      t.text :description
      t.integer :owner_id

      t.timestamps
    end
  end
end
