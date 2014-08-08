class LeaveRequest < ActiveRecord::Base
  belongs_to :user
  belongs_to :leave
end
