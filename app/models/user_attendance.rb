class UserAttendance < ActiveRecord::Base
  # establish_connection :attendance
  establish_connection DB_ATTENDANCE
  self.table_name = "acc_monitor_log"
end