class Admin::ReportsController < ApplicationController

	def loss_of_pays
		@loss_of_pays = LossOfPay.includes(:loss_of_pay_infos)
  end

  def create
    @report = Report.new(params)
    unless @report.valid?
      return render action: :loss_of_pays
    end
    case params[:report_type].downcase
      when 'lop'
        @result = @report.generate_lop_report
        logger.info "======================"
        logger.info @result.inspect
        logger.info "======================"
      when 'lopRefund'
        @report.print_lop_refunt
    end
  end

end
