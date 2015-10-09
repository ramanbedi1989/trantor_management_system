class Admin::UsersController < ApplicationController

  def import
	  if request.post?
	    if params[:file] && !params[:file].path.empty?
        CSV.foreach(params[:file].path, {headers: true, skip_blanks: true}) do |row|
          
          csv_user = OpenStruct.new(row.to_hash)
          
          u = User.find_by(ecode: csv_user.ecode)
          u = User.new unless u
          
          u.username = csv_user.username
          u.ecode = csv_user.ecode
          u.name = csv_user.name
          u.email = csv_user.email
          u.date_of_joining = csv_user.date_of_joining
          u.prior_exp = csv_user.prior_exp
          u.current_contact = csv_user.current_contact
          u.emergency_contact_no = csv_user.emergency_contact_no
          u.date_of_birth = csv_user.date_of_birth
          u.blood_group = csv_user.blood_group
          u.marriage_anniv_date = csv_user.marriage_anniv_date
          u.pan = csv_user.pan
          u.contractual_ecode = csv_user.contractual_ecode
          u.card_no = csv_user.card_no
          u.active = true
          u.role = csv_user.role
          u.bu = csv_user.bu
          u.last_working_day = csv_user.last_working_day
          u.notice_period= csv_user.notice_period
          
          # emp_type_id
          emp_type = EmpType.find_or_create_by(name: csv_user.emp_type)
          u.emp_type_id = emp_type.id 
          
          # designation_id
          designation = Designation.find_or_create_by(name: csv_user.designation)
          u.designation_id = designation.id
          
          # grade_id
          grade = Grade.find_or_create_by(name: csv_user.grade)
          u.grade_id = grade.id
          
          # manager_id
          manager = User.find_by(ecode: csv_user.ecode)
          u.manager_id = manager.id if manager
          
          # confirmation_id
          confirmation = Confirmation.find_or_create_by(name: csv_user.confirmation)
          u.confirmation_id = confirmation.id
          
          # status_id
          status = Status.find_or_create_by(name: csv_user.status)
          u.status_id = status.id
          
          # location_id
          location = Location.find_or_create_by(name: csv_user.location)
          u.location_id = location.id
          
          # gender_id
          gender = Gender.find_or_create_by(name: csv_user.gender)
          u.gender_id = gender.id
          
          # marital_status_id
          marital_status = MaritalStatus.find_or_create_by(name: csv_user.marital_status)
          u.marital_status_id = marital_status.id
          
          # lta_option_id
          lta_option = LtaOption.find_or_create_by(name: csv_user.lta_option)
          u.lta_option_id = lta_option.id
          
          if u.save
            logger.info "User #{u.name} | ecode #{u.ecode} created successfully"
          else
            logger.debug "Error occured while creating user #{u.name} | ecode #{u.ecode}"
            logger.debug u.errors.messages.to_s
          end
          
        end # CSV Loop Ends
	      flash.now[:notice] = "Users imported successfully"
	      redirect_to '/admin/users/import'
	    else
	      flash.now[:notice] = "Please provide a valid CSV."
	    end
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
