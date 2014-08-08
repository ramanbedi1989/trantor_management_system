class Leave < ActiveRecord::Base
  has_many :leave_credits
  has_many :attendances
end
