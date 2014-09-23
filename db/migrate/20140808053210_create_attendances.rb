class CreateAttendances < ActiveRecord::Migration
  def change
    create_table :attendances do |t|
      t.integer :user_id
      t.date :attendance_date
      t.boolean :present

      t.timestamps
    end
  end
end
