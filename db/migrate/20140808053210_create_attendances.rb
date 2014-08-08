class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.datetime :attendance_date
      t.boolean :present
      t.integer :leave_id
      t.integer :loss_of_pay_id
      t.boolean :half_day_leave, default: false

      t.timestamps
    end
  end
end
