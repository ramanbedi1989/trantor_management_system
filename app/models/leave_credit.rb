class LeaveCredit < ActiveRecord::Base
  
  validates :user_id, :leave_id, :leave_credited_date, presence: true
  belongs_to :user
  belongs_to :leave
end
