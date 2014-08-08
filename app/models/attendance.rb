class Attendance < ActiveRecord::Base
  belongs_to :user
  belongs_to :leave
  belongs_to :loss_of_pay
end
