class UserInfo < ActiveRecord::Base
  # establish_connection :attendance
  establish_connection DB_ATTENDANCE
  self.table_name = "userinfo"
end