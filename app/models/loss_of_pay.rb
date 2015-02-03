class LossOfPay < ActiveRecord::Base
  has_many :loss_of_pay_infos

  scope :lop, -> { where("name = ?", 'LOP').first}
  scope :lop_refund, -> { where("name = ?", 'LOP Refund').first}



end
