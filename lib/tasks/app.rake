namespace :app do
  desc "This task generates dummy LOP data to ease the way for csv generation"
  task :fake_data_lop => :environment do
    10.times do |i|
      u = User.create!(username: "u#{i}", ecode: "ecode#{i}", name: "name#{i}", email: "email#{i}@xyz.com", gender_id: 1, card_no: rand(26609047), role: 'employee')
      puts "** Created #{ u.username }"
      a = Attendance.create!(user_id: u.id, attendance_date: (Date.today - rand(30).send(:days)), present: false)
      li = LeaveInfo.create!(user_id: u.id)
      LossOfPayInfo.create!(loss_of_pay_id: LossOfPay.lop.id, attendance_id: a.id, leave_info_id: li.id)
    end
  end

  desc "This task will create users with manager role"
  # rake app:create_managers
  task :create_managers => :environment do
    ['Gurdeep', 'Vibhor', 'Harish'].each do |user|
      puts "--> Adding #{user}"
      User.create!(username: user, name: user, role: 'manager', ecode:("E" + rand(500).to_s), gender_id: 1, card_no: (rand(999999).to_s), email: (user+"@trantorinc.com"))
    end
  end

  desc "Associate manager and project"
  # rake app:create_project_user
  task :create_project_user => :environment do
    ProjectUser.create!(:user_id => User.first.id, :project_id => Project.first.id)
  end

  # rake app:create_admin
  task :create_admin => :environment do
     puts "==> Creating admin: Nidhi Ayri"
     attributes = 
      {
        "username"=>"nidhi.ayri", 
        "ecode"=>"E00015", 
        "name"=>"Nidhi Ayri", 
        "emp_type_id"=>1, 
        "designation_id"=>20, 
        "grade_id"=>3, 
        "date_of_joining"=> "16-Apr-2012",       
        "bu"=>"Support", 
        "prior_exp"=>"8", 
        "email"=>"nidhi.ayri@trantorinc.com", 
        "confirmation_id"=>1, 
        "status_id"=>1, 
        "current_contact"=>"9803083292", 
        "emergency_contact_no"=>"9041393292", 
        "date_of_birth"=> "22/11/1980", 
        "gender_id"=> 2, 
        "blood_group"=>"B+", 
        "marital_status_id"=>"1", 
        "marriage_anniv_date"=> "18/11/2005", 
        "pan"=>"BFTPS8845G",
        "lta_option_id"=>1,
        "pf_no"=>nil, 
        "esi_no"=>nil, 
        "card_no"=>6205802, 
        "active"=>true,                 
        "role"=>"admin"
      } 
      User.create!(attributes)
  end

end