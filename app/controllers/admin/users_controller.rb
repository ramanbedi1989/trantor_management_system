class Admin::UsersController < ApplicationController

	def import
	  if request.post?
		file = params[:file]
		 inputPath = params[:file].path
		 lines = File.readlines(inputPath)
		 lines[1..-1].each do |line|		 	
		 	User.import_user(line)
		 end
	    
	  end
	end

end
