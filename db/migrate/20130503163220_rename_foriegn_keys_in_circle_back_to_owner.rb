class RenameForiegnKeysInCircleBackToOwner < ActiveRecord::Migration
  def up
    drop_table :circles

    create_table :circles do |t|
      t.string :name
      t.text :description
      t.integer :owner_id

      t.timestamps
    end
  end

  def down
    drop_table :circles

    create_table :circles do |t|
      t.string :name
      t.text :description
      t.integer :user_id

      t.timestamps
    end
  end
end
