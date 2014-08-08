class CreateMedReimbOptions < ActiveRecord::Migration
  def change
    create_table :med_reimb_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
