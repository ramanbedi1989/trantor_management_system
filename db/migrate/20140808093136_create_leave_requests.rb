class CreateLeaveRequests < ActiveRecord::Migration
  def change
    create_table :leave_requests do |t|
      t.integer :user_id
      t.integer :leave_id
      t.datetime :leave_date
      t.boolean :approved
      t.boolean :rejected
      t.boolean :deleted

      t.timestamps
    end
  end
end
