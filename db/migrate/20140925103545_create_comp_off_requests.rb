class CreateCompOffRequests < ActiveRecord::Migration
  def change
    create_table :comp_off_requests do |t|
      t.integer :user_id
      t.integer :days
      t.text :reason
      t.boolean :approved, default: false
      t.boolean :rejected, default: false
      t.date :applied_date
      t.date :approved_date

      t.timestamps
    end
  end
end
