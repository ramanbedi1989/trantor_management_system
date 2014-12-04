require 'calculate_attendance'
require 'increment_leaves'
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
    IncrementLeaves.increment_earned_leaves(users, 1)
  end

  desc "Mail employees which are absent without pay"
  task mail_absent_without_pay: :environment do 
    #todo
  end

  desc "Deduct loss of pay for employees that are absent without pay"
  task increment_earned_leaves: :environment do 
    #todo
  end
end