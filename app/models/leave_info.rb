class LeaveInfo < ActiveRecord::Base
  has_many :leave_credits
  has_many :loss_of_pay_infos
  after_save :remove_leave_credits_and_lops

  def remove_leave_credits_and_lops
    if canceled && !approved && !rejected
      leave_credits.each do |lc|
        if lc.half_day_leave
          other_leave = LeaveCredit.find(lc.other_half_leave_id)
          if other_leave.consumed
            lc.update(consumed: false, leave_info_id: nil, attendance_id: nil)
          else
            other_leave.destroy
            lc.update(consumed: false, leave_info_id: nil, attendance_id: nil, half_day_leave: false, other_half_leave_id: nil)
          end
        else
          lc.update(consumed: false, leave_info_id: nil, attendance_id: nil)
        end
      end
      loss_of_pay_infos.each do |lop|
        lop.delete
      end
    end
  end
end
