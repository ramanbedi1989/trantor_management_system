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