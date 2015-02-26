require 'rufus-scheduler'
require 'rake'

@scheduler = Rufus::Scheduler.new


# FETCH ATTENDANCE EVERY NIGHT
job = @scheduler.cron '00 01 * * *' do
	puts "--> Executing the task"
	require 'rake'
	Rails.application.load_tasks
	Rake::Task["scheduled_tasks:fetch_previous_day_attendance"].invoke  
end



# THIS JOB WILL BE EXECUTED EVERY LAST DAY OF THE MONTH
job = @scheduler.cron '50 23 L * *' do
	puts "--> Executing the task"
	require 'rake'
	Rails.application.load_tasks
	Rake::Task["scheduled_tasks:increment_earned_leaves"].invoke  
end

# THIS TASK WILL CARRY FORWARD CASUAL AND SICK LEAVES AT THE YEAR END
# ON THE FIRST DAY OF EVERY YEAR AT 02 AM
job = @scheduler.cron '00 02 01 01 *' do
  print "do something at a given point in time"
end