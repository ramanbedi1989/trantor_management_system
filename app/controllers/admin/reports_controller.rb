class Admin::ReportsController < ApplicationController

	def loss_of_pays
		@loss_of_pays = LossOfPay.includes(:loss_of_pay_infos)
  end

  def create
    begin
      @report = Report.new(params)
      unless @report.valid?
        return render action: :loss_of_pays
      end
      case params[:report_type].to_sym
        when :lop
          file = @report.generate_lop_report
          send_file(file)    
      end
      rescue => e
        log_error(e)
        flash[:alert] = e.message
        redirect_to loss_of_pays_admin_reports_path
    end
  end

end
