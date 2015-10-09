class AddNoticeAndLastWorkingDayToUsers < ActiveRecord::Migration
  def change
    add_column :users, :last_working_day, :date
    add_column :users, :notice_period, :integer, defaults: 30
  end
end
