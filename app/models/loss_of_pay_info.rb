class LossOfPayInfo < ActiveRecord::Base
  belongs_to :attendance
  belongs_to :loss_of_pay
  belongs_to :leave_info
end
