class CreateLossOfPays < ActiveRecord::Migration
  def change
    create_table :loss_of_pays do |t|
      t.string :name

      t.timestamps
    end
  end
end
