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
    @manager_id   = params[:manager_id]
    @all = (params[:all_employees] && params[:all_employees] == '1')
  end


  def generate_lop_report  
    if !@ecode.blank?
      @loss_of_pays = LossOfPayInfo.joins(:attendance => :user).where("attendances.user_id=?", @user.id)
      .where("DATE(attendances.attendance_date) >= ? AND DATE(attendances.attendance_date) <= ? ", Date.parse(@from_date), Date.parse(@to_date))
    elsif !@project.blank?
      users_ids = @project.users.collect(&:id)
      @loss_of_pays = LossOfPayInfo.joins(:attendance => :user).where("user_id IN (?)", users_ids)
      .where("DATE(attendances.attendance_date) >= ? AND DATE(attendances.attendance_date) <= ? ", Date.parse(@from_date), Date.parse(@to_date))
    elsif !@manager_id.blank?
      users_ids = User.where(manager_id: @manager_id).collect(&:id)
      @loss_of_pays = LossOfPayInfo.joins(:attendance => :user).where("user_id IN (?)", users_ids)
      .where("DATE(attendances.attendance_date) >= ? AND DATE(attendances.attendance_date) <= ? ", Date.parse(@from_date), Date.parse(@to_date))
    elsif @all
      users_ids = User.all.collect(&:id)
      @loss_of_pays = LossOfPayInfo.joins(:attendance => :user).where("user_id IN (?)", users_ids)
      .where("DATE(attendances.attendance_date) >= ? AND DATE(attendances.attendance_date) <= ? ", Date.parse(@from_date), Date.parse(@to_date))
    end
    generate_lop_csv(lop_dates_by_user_id)
  end

  def generate_attendance_report
    if !@ecode.blank?
       @user = User.find_by_ecode(@ecode)
      @attendances = Attendance.joins(:user).where("user_id = ?", @user.id)
    elsif  !@project.blank?
      users_ids = @project.users.collect(&:id)
      @attendances = Attendance.joins(:user).where("user_id IN (?)", users_ids).includes(:user)
    elsif !@manager_id.blank?
      users_ids = User.where(manager_id: @manager_id).collect(&:id)
      @attendances = Attendance.joins(:user).where("user_id IN (?)", users_ids).includes(:user)
    elsif @all
      @attendances = Attendance.joins(:user).includes(:user)
    end    
    generate_attendance_csv(collect_attendance_data)
  end

 
  def collect_attendance_data        
     return {}  if @attendances.blank?
     attendance_info = {}
     @attendances.each do |attendance|
        attendance_info[attendance.user]||=Hash.new
        attendance_info[attendance.user].merge!({attendance.attendance_date.day => attendance.present? ? 'P' : attendance.leave_or_absent_or_weekend})
     end
     attendance_info
  end

  def lop_dates_by_user_id()
    return {}  if @loss_of_pays.blank?
    lop_infos = Hash.new
    @loss_of_pays.each do |lop|
      lop_infos[lop.user]||=Hash.new
      lop_infos[lop.user].merge!({lop.attendance_date.day => (lop.refund? ? "LOP Refund" : "LOP")})       
    end
    lop_infos
  end

#------------------------------------------------------------------------------------------------------------
  def generate_lop_csv(data = {})
    raise "No data exists" if data.blank?
    FileUtils.mkdir('csv') rescue ['csv']
    start_date = Date.parse(@from_date)
    end_date = Date.parse(@to_date)
    filename = "#{ Rails.root }/csv/lopReport_#{rand(Time.now.strftime("%s").to_i)}.csv"
    File.open(filename, 'w') do |file|
      ## HEADER ##
      file.write("username, ecode, Manager, Project")
      start_date.step(end_date).each do |date|
        file.write(",")
        file.write(date.strftime("%d-%m-%Y"))
      end
      file.write("\n")
    ## LOP DATA ##      
    data.each_pair do |user, lops_hash|                         #lop_days is an array    
      file.write("#{ user.username }, #{ user.ecode }, #{ user.manager.try(:name) }, #{ user.c_projects }")
      start_date.step(end_date).each do |date|
        day = date.day       
        unless (lops_hash.keys & [day]).blank?
          file.write("," + lops_hash[day].to_s)
        else
          file.write(",")
         end
        end
        file.write("\n")
      end
    end
    return filename
  end

#------------------------------------------------------------------------------------------------------------

  def generate_attendance_csv(data={})
      raise "No data exists" if data.blank?
      start_date = Date.parse(@from_date)
      end_date = Date.parse(@to_date)
      filename = "#{Rails.root}/attendance.csv"
      File.open(filename, 'w') do |file|
        ## HEADER ##
        file.write("")
        start_date.step(end_date).each do |date|
          file.write(",")
          file.write(date.strftime("%d-%m-%Y"))
        end
        file.write("\n")
       data.each_pair do |user, att_hash| 
         file.write("#{ user.ecode } - #{user.username }")
         start_date.step(end_date).each do |date|
         day = date.day       
          if !(att_hash.keys & [day]).blank?
            file.write("," + att_hash[day].to_s)
          elsif (date.strftime("%a").downcase.match(/sun/) ||  date.strftime("%a").downcase.match(/sat/))
            file.write("," + "W")
          else
            file.write("," + "NA")
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
    if @project_id.blank? && @ecode.blank? && @manager_id.blank? && @all.blank?
      return self.errors.add(:base, "Please select either Ecode or Project Name Or Manager Or Select all")
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
