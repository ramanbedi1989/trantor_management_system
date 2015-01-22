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

end