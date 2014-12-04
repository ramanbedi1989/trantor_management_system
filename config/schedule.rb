set :output, "#{Rails.root}/cron_log.log"

every 1.day, at: '2:00 am' do
  rake "scheduled_tasks:fetch_previous_day_attendance"
end

every 1.month do 
  rake "scheduled_tasks:increment_earned_leaves"
end

every '0 1 15 * *' do 
  rake "scheduled_tasks:mail_absent_without_pay"
end

every '0 1 19 * *' do 
  rake "scheduled_tasks:deduct_absent_without_pay"
end