# # config/unicorn.rb
# worker_processes Integer(ENV["WEB_CONCURRENCY"] || 3)
# timeout 15
# preload_app true
# APP_ROOT = "/home/psahni/projects/where_is_everyone"
# pid "#{APP_ROOT}/tmp/pids/unicorn.pid"

# # Loging
# stderr_path "#{APP_ROOT}/log/unicorn.log"
# stdout_path "#{APP_ROOT}/log/unicorn.log"

# before_fork do |server, worker|
#   Signal.trap 'TERM' do
#     puts 'Unicorn master intercepting TERM and sending myself QUIT instead'
#     Process.kill 'QUIT', Process.pid
#   end

#   defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
# end

# after_fork do |server, worker|
#   Signal.trap 'TERM' do
#     puts 'Unicorn worker intercepting TERM and doing nothing. Wait for master to send QUIT'
#   end

#   defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
# end


# before_exec do |server|
#   ENV['BUNDLE_GEMFILE'] = "#{app_dir}/Gemfile"
# end

# Set your full path to application.
app_dir = File.expand_path('../../', __FILE__)

# Set unicorn options
worker_processes 2
preload_app true
timeout 360

# Fill path to your app
working_directory app_dir

# Set up socket location
listen "#{app_dir}/tmp/sockets/unicorn.sock", :backlog => 64

# Loging
stderr_path "#{app_dir}/log/unicorn.log"
stdout_path "#{app_dir}/log/unicorn.log"

# Set master PID location
pid "#{app_dir}/tmp/pids/unicorn.pid"

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.connection.disconnect!
  old_pid = "#{server.config[:pid]}.oldbin"
  if File.exists?(old_pid) && server.pid != old_pid
    begin
      sig = (worker.nr + 1) >= server.worker_processes ? :QUIT : :TTOU
      Process.kill(sig, File.read(old_pid).to_i)
    rescue Errno::ENOENT, Errno::ESRCH
      # someone else did our job for us
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and ActiveRecord::Base.establish_connection
end

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{app_dir}/Gemfile"
end