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
    if !@ecode.blank?
      @loss_of_pays = LossOfPayInfo.joins(:attendance => :user).where("attendances.user_id=?", @user.id)
      .where("DATE(attendances.attendance_date) >= ? AND DATE(attendances.attendance_date) <= ? ", Date.parse(@from_date), Date.parse(@to_date))
      .where("loss_of_pay_infos.loss_of_pay_id=?", LossOfPay.lop.id)
    elsif @project
      users_ids = @project.users.collect(&:id)
      @loss_of_pays = LossOfPayInfo.joins(:attendance => :user).where("user_id IN (?)", users_ids)
    end
    generate_csv(lop_dates_by_user_id)
  end


  def lop_dates_by_user_id()
    return {}  if @loss_of_pays.blank?
    lop_infos = Hash.new
    @loss_of_pays.each do |lop|
      lop_infos[lop.user.username] ||= Array.new
      lop_infos[lop.user.username].push(lop.attendance_date.day)
    end
    lop_infos
  end

  def generate_csv(data = {})
    raise "No data exists" if data.blank?
    puts "--> Fetched Data is:-"
    puts data.inspect
    FileUtils.mkdir('csv') rescue ['csv']
    start_date = Date.parse(@from_date)
    end_date = Date.parse(@to_date)
    filename = "#{Rails.root}/csv/lopDate#{rand(Time.now.strftime("%s").to_i)}.csv"
    File.open(filename, 'w') do |file|
      ## HEADER ##
      file.write("")
      start_date.step(end_date).each do |date|
        file.write(",")
        file.write(date)
      end
      file.write("\n")
    ## LOP DATA ##
    data.each_pair do |user_id, lop_days|                         #lop_days is an array
      file.write("#{ user_id}")
      start_date.step(end_date).each do |date|
        day = date.day
          unless (lop_days & [day]).blank?
            file.write(",LOP")
          else
            file.write(",")
          end
        end
        file.write("\n")
      end
    end
    return filename
  end


  def generate_lop_report_refund_report
    # TO BE DONE
  end



#--------------------------------------------------------------------------------------

  protected

  # VALIDATE
  def selection_of_project_and_emp_code
    if @project_id.blank? && @ecode.blank?
      return self.errors.add(:base, "Please select either Ecode or Project Name")
    end
    if !@ecode.blank?
      @user = User.find_by_ecode(@ecode)
      self.errors.add(:ecode, "Invalid Employee Code") unless @user
    elsif !@project_id.blank?
      @project  = Project.includes(:users).where(id: @project_id).first
      self.errors.add(:project_id, "Invalid Project Selected") unless @project
    end
  end


end

#
#r=Report.new({ecode: "e00031", project_id: Project.first.id, from_date: "16/11/2014", to_date: "15/12/2014"})
#

# 2.1.2p95 :125 > File.open("csv/file.csv", 'w'){|f|
#   2.1.2p95 :126 >     array.each do |n|
#     2.1.2p95 :127 >       f.write(",#{n}")
#     2.1.2p95 :128?>     end
#   2.1.2p95 :129?>   }
