class UserInfo < ActiveRecord::Base
  establish_connection :attendance
  self.table_name = "userinfo"
end