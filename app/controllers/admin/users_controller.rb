class Admin::UsersController < ApplicationController

	def import
	  if request.post?
		file = params[:file]
		 inputPath = params[:file].path
		 lines = File.readlines(inputPath)
		 lines[1..-1].each do |line|		 	
		 	User.import_user(line)
		 end
		 flash.now[:notice] = "Users imported successfully"	    
	  end
	end

	def export
		if request.post?
			file = User.export_all
			send_file(file)    
		else
			@users = User.all
		end
		
	end
end
