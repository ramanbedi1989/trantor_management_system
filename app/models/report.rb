class Report


  attr_accessor :ecode, :project_id, :from_date, :to_date

  include ActiveModel::Model

  # VALIDATIONS
  validates :to_date, :from_date, presence: true
  validate :selection_of_project_and_emp_code


  def initialize(params)
    @ecode   = params[:ecode]
    @project_id = params[:project_id]
    @from_date = params[:from_date]
    @to_date   = params[:to_date]
  end


  def generate_lop_report
    if @ecode
      loss_of_pays = LossOfPayInfo.includes(:attendance => :user).where("attendances.user_id =?", @user.id)
      .where("DATE(attendances.attendance_date) >= ? AND DATE(attendances.attendance_date) <= ? ", Date.parse(@from_date), Date.parse(@to_date))
      .where("loss_of_pay_infos.loss_of_pay_id = ?", LossOfPay.lop.id)

    end
  end

  def generate_lop_report_refund_report
  end


  protected


  def selection_of_project_and_emp_code
    if @project.blank? && @ecode.blank?
      return self.errors.add(:base, "Please select either Ecode or Project Name")
    end
    if @ecode
      @user = User.find_by_ecode(@ecode)
      self.errors.add(:ecode, "Invalid Employee Code") unless @user
    elsif @project_id
      @project  = Project.find_by_id(@project_id)
      self.errors.add(:project_id, "Invalid Project Selected") unless @project
    end
  end

end