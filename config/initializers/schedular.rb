require 'rufus-scheduler'
require 'rake'

@scheduler = Rufus::Scheduler.new


job = @scheduler.cron '00 01 * * *' do
	puts "--> Executing the task"
	require 'rake'
	Rails.application.load_tasks
	Rake::Task["scheduled_tasks:fetch_previous_day_attendance"].invoke  
end