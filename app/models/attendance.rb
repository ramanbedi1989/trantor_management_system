class Attendance < ActiveRecord::Base

  validates :user_id, presence: true
  belongs_to :user
  has_one :leave_credit
  has_one :loss_of_pay_info


  def leave_or_absent_or_weekend
  	if self.leave_credit.present?
  		return "L"
  	elsif (self.attendance_date.strftime("%a").downcase.match(/sun/) || self.attendance_date.strftime("%a").downcase.match(/sat/))
  		return	"W"
  	else 
  	 return	"A"
  	end
  end

end
