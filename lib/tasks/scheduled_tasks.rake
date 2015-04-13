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


  desc "Mail to users about loss of pays" do
    task loss_of_pay_reminder: :environment do
      prev_month_date = (Date.today-1.month)+1.day
      today = Date.today
      users = User.users_with_loss_of_pays(prev_month_date, today)
      users.each do |user|
        EmployeeEmails.loss_of_pay_reminder(user).deliver
      end  
    end
  end

  desc "Mail to managers about loss of pay" 
  task loss_of_pay_reminder_manager: :environment do
      prev_month_date = (Date.today-1.month)+1.day
      today = Date.today
      users = User.users_with_loss_of_pays(prev_month_date, today)
      managers = users.collect(&:manager).compact.uniq
      managers.each do |manager|
        EmployeeEmails.loss_of_pay_reminder_manager(manager).deliver
      end
    end
  end

end

# rake attendance
task :attendance do
  puts "--> Executing the attendance fetching task"
  Rake::Task["scheduled_tasks:fetch_previous_day_attendance"].invoke 
  puts "--> Task executed. Please check logs.."
end
