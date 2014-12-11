class Admin::ReportsController < ApplicationController

	def loss_of_pays
		@loss_of_pays = LossOfPay.includes(:loss_of_pay_infos)
  end

  def create
    case params[:report_type].downcase
      when 'lop'
       
      when 'lopRefund'
    end
  end

end
