class RemoveProjectIdFromUsers < ActiveRecord::Migration
 
  def up
  	User.all.each do |user|
  	  ProjectUser.create(:user => user, :project => user.project) if user.respond_to?(:project) && user.project
  	end
  	remove_column :users, :project_id
  end

  def down
  	add_column :users, :project_id, :integer
  end

end
