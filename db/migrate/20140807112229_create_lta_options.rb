class CreateLtaOptions < ActiveRecord::Migration
  def change
    create_table :lta_options do |t|
      t.string :name

      t.timestamps
    end
  end
end
