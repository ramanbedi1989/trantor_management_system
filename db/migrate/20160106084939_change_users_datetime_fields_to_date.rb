class ChangeUsersDatetimeFieldsToDate < ActiveRecord::Migration
  def change
    change_column :users, :date_of_joining, :date
    change_column :users, :date_of_birth, :date
  end
end
