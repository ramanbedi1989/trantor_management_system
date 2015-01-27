class LossOfPayInfo < ActiveRecord::Base
  belongs_to :attendance
  belongs_to :loss_of_pay
  belongs_to :leave_info

  delegate :user, :to => :attendance
  delegate :attendance_date, :to => :attendance


  def lop?
  	loss_of_pay == LossOfPay.lop
  end

  def refund?
  	loss_of_pay == LossOfPay.lop_refund
  end

end
