class AddPhoneNumbersToUser < ActiveRecord::Migration
  def change
    add_column :users, :phone, :string
    add_column :users, :mobile, :string
  end
end
