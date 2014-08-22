class Attendance < ActiveRecord::Base

  validates :user_id, presence: true
  belongs_to :user
  belongs_to :leave_credit
  belongs_to :loss_of_pay
end
