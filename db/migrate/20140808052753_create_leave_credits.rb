class CreateLeaveCredits < ActiveRecord::Migration
  def change
    create_table :leave_credits do |t|
      t.integer :user_id
      t.integer :leave_id
      t.datetime :leave_applied_date
      t.datetime :leave_approved_date
      t.datetime :leave_credited_date
      t.boolean :consumed, default: false
      t.boolean :approved, default: false
      t.boolean :rejected, default: false
      t.boolean :cancel, default: false
      t.string :reason
      t.date :date_from
      t.date :date_to


      t.timestamps
    end
  end
end
