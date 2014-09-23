class CreateLeaveCredits < ActiveRecord::Migration
  def change
    create_table :leave_credits do |t|
      t.integer :user_id
      t.integer :leave_id
      t.integer :attendance_id
      t.integer :leave_info_id
      t.date :leave_credited_date
      t.boolean :consumed, default: false
      t.boolean :half_day_leave, default: false
      t.boolean :is_first_half
      t.integer :other_half_leave_id

      t.timestamps
    end
  end
end
