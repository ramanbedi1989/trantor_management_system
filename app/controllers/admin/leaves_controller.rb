class Admin::LeavesController < ApplicationController

	def index
	end


	def create
	  user = User.find_by_id(params[:la][:user])
	  if user.send(params[:la][:leave_type], params[:la][:number].to_i)
	  	flash[:notice] = "Leaves incremented successfully"	
	  else
	  	flash[:alert] = "Leaves can not be incremented"
	  end
	  redirect_to admin_leaves_path
	end


end
