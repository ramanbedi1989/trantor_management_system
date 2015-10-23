class CreateKras < ActiveRecord::Migration
  def change
    create_table :kras do |t|
      t.integer :user_id
      t.string :target
      t.datetime :start_data
      t.datetime :end_data
      t.text :commetns
      t.timestamps null: false
    end
  end
end
