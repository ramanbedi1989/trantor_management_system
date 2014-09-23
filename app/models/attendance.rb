class Attendance < ActiveRecord::Base

  validates :user_id, presence: true
  belongs_to :user
  has_one :leave_credit
  has_one :loss_of_pay_info
end
