class CreateLeaveInfos < ActiveRecord::Migration
  def change
    create_table :leave_infos do |t|
      t.integer :user_id
      t.date :date_from
      t.date :date_to
      t.string :reason
      t.date :leave_applied_date
      t.date :leave_approved_date
      t.boolean :approved, default: false
      t.boolean :rejected, default: false
      t.boolean :cancelled, default: false
      t.boolean :cancel_request, default: false

      t.timestamps
    end
  end
end
