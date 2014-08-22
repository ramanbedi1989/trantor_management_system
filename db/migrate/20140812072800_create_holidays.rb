class CreateHolidays < ActiveRecord::Migration
  def change
    create_table :holidays do |t|
      t.string :name
      t.date :date
      t.boolean :day_shift

      t.timestamps
    end
  end
end
