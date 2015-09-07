class RenameUserFields < ActiveRecord::Migration
  
  def up
  	rename_column :users, :med_reimb_option_id, :contractual_ecode
  	change_column :users, :contractual_ecode, :string
  end

  def down
  	change_column :users, :contractual_ecode, :integer
  	rename_column :users, :contractual_ecode, :med_reimb_option_id
  end

end
