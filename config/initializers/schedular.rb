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
# This job will increment earned leaves
job = @scheduler.cron '30 23 L * *' do
	puts "--> Executing the task"
	require 'rake'
	Rails.application.load_tasks
	Rake::Task["scheduled_tasks:increment_earned_leaves"].invoke  
end

# THIS TASK WILL CARRY FORWARD CASUAL AND SICK LEAVES AT THE YEAR END
# ON THE FIRST DAY OF EVERY YEAR AT 2:00 AM
job = @scheduler.cron '00 02 01 01 *' do
  puts "--> Executing the task"
  require 'rake'
  Rails.application.load_tasks
  Rake::Task['scheduled_tasks:carry_forward_casual_leaves']
end

# THIS JOB WILL BE EXECUTED ON Jan 1
# 2 Casual and 2 sick leave credit to all employees
# 03:00 am
job = @scheduler.cron '00 03 01 01 *' do
  puts "--> Executing the task"
  require 'rake'
  Rails.application.load_tasks
  Rake::Task['scheduled_tasks:increment_leaves']
end

# THIS JOB WILL BE EXECUTED ON April 1
# 2 Casual and 2 sick leave credit to all employees
# 03:00 am
job = @scheduler.cron '00 03 01 04 *' do
  puts "--> Executing the task"
  require 'rake'
  Rails.application.load_tasks
  Rake::Task['scheduled_tasks:increment_leaves_2']
end


# THIS JOB WILL BE EXECUTED ON July 1
# 2 Casual and 2 sick leave credit to all employees
# 03:00 am
job = @scheduler.cron '00 03 01 07 *' do
  puts "--> Executing the task"
  require 'rake'
  Rails.application.load_tasks
  Rake::Task['scheduled_tasks:increment_leaves_2']
end


# THIS JOB WILL BE EXECUTED ON 1 Oct
# 1 Casual and 1 sick leave credit to all employees
# 03:00 am
job = @scheduler.cron '00 03 01 10 *' do
  puts "--> Executing the task"
  require 'rake'
  Rails.application.load_tasks
  Rake::Task['scheduled_tasks:increment_leaves_1']
end



# This job will be executed on the last day of every month
# to notify those users who have earned leaves equal to 33
# 23:45 pm on the last day of every month
job = @scheduler.cron '45 23 L * *' do
  puts "--> Executing the task"
  require 'rake'
  Rails.application.load_tasks
  Rake::Task["scheduled_tasks:earned_leaves_reminder"].invoke  
end