class CreateLossOfPayInfos < ActiveRecord::Migration
  def change
    create_table :loss_of_pay_infos do |t|
      t.integer :loss_of_pay_id
      t.integer :attendance_id
      t.integer :leave_info_id

      t.timestamps
    end
  end
end
