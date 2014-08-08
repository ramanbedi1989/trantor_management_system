class CreateLeaveCredits < ActiveRecord::Migration
  def change
    create_table :leave_credits do |t|
      t.integer :user_id
      t.datetime :leave_credited_date
      t.integer :leave_id
      t.boolean :consumed, default: false

      t.timestamps
    end
  end
end
