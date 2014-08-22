class LeaveCredit < ActiveRecord::Base
  
  validates :user_id, :leave_id, presence: true
  belongs_to :user
  belongs_to :leave
  has_one :attendance
end
