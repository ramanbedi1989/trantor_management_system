require 'calculate_attendance'
require 'increment_leaves'


# rake scheduled_tasks:fetch_previous_day_attendance
namespace :scheduled_tasks do
  desc "Fetch attendance for the previous day"
  task fetch_previous_day_attendance: :environment do 
    users = User.all
    yesterday = Date.today - 1
    CalculateAttendance.calculate_and_insert(users, yesterday, yesterday)
  end

  desc "Increment earned leaves"
  task increment_earned_leaves: :environment do 
    users = User.all
    users.each do |user|
      user.increment_earned_leaves
    end    
  end

  desc "Mail employees which are absent without pay"
  task mail_absent_without_pay: :environment do 
    #todo
  end

  desc "Carry forward leaves"
  task carry_forward_casual_leaves: :environment do
    users = User.all
    users.each do |user|
      user.carry_forward_casual_leaves
    end    
  end

  desc "Increment sick and casual leaves"
  task increment_leaves_2: :environment do
    users = User.all
    users.each do |user|
      user.increment_leaves(2)
    end
  end


  desc "Increment sick and casual leaves"
  task increment_leaves_1: :environment do
    users = User.all
    users.each do |user|
      user.increment_leaves(1)
    end
  end


end

# rake attendance
task :attendance do
  puts "--> Executing the attendance fetching task"
  Rake::Task["scheduled_tasks:fetch_previous_day_attendance"].invoke 
  puts "--> Task executed. Please check logs.."
end
