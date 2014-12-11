class ReportsController < ApplicationController

	def loss_of_pays
		@loss_of_pays = LossOfPay.all.includes(:loss_of_pay_infos)
	end
end
