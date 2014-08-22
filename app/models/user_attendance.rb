class UserAttendance < ActiveRecord::Base
  establish_connection :attendance
  self.table_name = "acc_monitor_log"
end