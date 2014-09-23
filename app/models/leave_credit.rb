class LeaveCredit < ActiveRecord::Base
  HALF_DAY_LEAVES = ["First Half", "Second Half"]

  validates :user_id, :leave_id, presence: true
  belongs_to :user
  belongs_to :leave
  belongs_to :attendance
  belongs_to :leave_info
end
