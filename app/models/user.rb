require 'increment_leaves'
class User < ActiveRecord::Base
  ALLOWED_LEAVES = ["CL/EL/CompOff", "Sick Leave", "Present But Card Not Shown", "On Office Duty/Client Side", "Maternity Leave", "Half Day Sick Leave"]
  ROLES = %w[employee manager admin]
  devise :ldap_authenticatable, :rememberable, :trackable

  validates :username, :role, :gender, :card_no, :ecode, :email, presence: true
  belongs_to :emp_type
  belongs_to :designation
  belongs_to :grade
  belongs_to :gender
  belongs_to :project
  has_many :project_users, :dependent => :destroy
  has_many :projects, :through => :project_users
  belongs_to :confirmation
  belongs_to :status
  belongs_to :location
  belongs_to :marital_status
  belongs_to :lta_option
  belongs_to :med_reimb_option
  belongs_to :manager, class_name: "User", foreign_key: :manager_id
  has_many :leave_credits, :dependent => :destroy
  has_many :attendances
  has_many :leave_infos, :dependent => :destroy

  def manager?
    if User.find_by_manager_id(self.id)
      true
    else
      false
    end
  end

  def role?(base_role)
    role == base_role.to_s
  end

  def role_enum
    ROLES
  end

  def self.find_managers
    where(role: 'manager')
  end

  def c_projects
    projects.map(&:name).join(';')
  end

#------------------------------------------------------------------------------------

  def casual_leaves
    self.leave_credits.where("leave_id =?", Leave.casual_leave.id)
  end

  def sick_leaves
    self.leave_credits.where("leave_id =?", Leave.sick_leave.id)
  end

  def earned_leaves
    self.leave_credits.where("leave_id =?", Leave.earned_leave.id)
  end

#------------------------------------------------------------------------------------

  # 2 casual 2 sick
  def increment_leaves(n)
    n.times do
      leave_credit = self.leave_credits.build(leave_id: Leave.sick_leave.id,
                                              leave_credited_date: Date.today,
                                              consumed: false
      )
      leave_credit.save
    end
    n.times do
      leave_credit = self.leave_credits.build(leave_id: Leave.casual_leave.id,
                                              leave_credited_date: Date.today,
                                              consumed: false
      )
      leave_credit.save
    end
    self.leave_credits
  end


  def increment_casual_leaves(n)
     n.times do
      leave_credit = self.leave_credits.build(leave_id: Leave.casual_leave.id,
                                                leave_credited_date: Date.today,
                                                consumed: false
        )
      leave_credit.save
    end
  end

  def increment_sick_leaves(n)
    n.times do
      leave_credit = self.leave_credits.build(leave_id: Leave.sick_leave.id,
                                                leave_credited_date: Date.today,
                                                consumed: false
        )
      leave_credit.save
    end
  end


  # INCREMENT UPTO 36
  MAX_EARNED_LEAVES = 36
  def increment_earned_leaves(increment_by=1)
    earned_leaves = self.leave_credits.where("leave_id =?", Leave.earned_leave.id).count
    return false if earned_leaves == MAX_EARNED_LEAVES
    left_leaves = MAX_EARNED_LEAVES - earned_leaves
    if increment_by <= left_leaves
      IncrementLeaves.increment_earned_leaves([self], increment_by)
    else
      return false
    end
  end

#------------------------------------------------------------------------------------

  def carry_forward_casual_leaves
    casual_leaves_count = self.leave_credits.where("leave_id =?", Leave.casual_leave.id).count
    sick_leaves_count = self.leave_credits.where("leave_id =?", Leave.sick_leave.id).count       
    if casual_leaves_count > 4
      delete_count = casual_leaves_count - 4     #Delete all casual leaves leaving 4
      destroy_casual_leaves(delete_count)
      delete_count = nil
      destroy_sick_leaves(delete_count)         # Delete all sicak leaves
      return
    end 
    case casual_leaves_count
      when 4                                      #Destroy all sick leaves
        delete_count = nil
      when 3                                      #Destroy all sick leaves leaving 1        
        delete_count = sick_leaves_count - 1
      when 2                                      #Destroy all sick leaves leaving 2
        delete_count = sick_leaves_count - 2
      when 1                                      #Destroy all sick leaves leaving 3
        delete_count = sick_leaves_count - 3
      when 0                                      #Destroy all sick leaves leaving 4
        delete_count = sick_leaves_count - 4
      end
    destroy_sick_leaves(delete_count)
  end

#------------------------------------------------------------------------------------


  def destroy_sick_leaves(delete_count)
    sick_leaves = self.leave_credits.where("leave_id =?", Leave.sick_leave.id).order('created_at')
    if delete_count == nil      
      sick_leaves.each do |s|
        s.destroy
      end
      return
    end
    return if delete_count < 1
    delete_count.times do |i|
      sick_leaves[i].destroy
    end
  end

#------------------------------------------------------------------------------------

  def destroy_casual_leaves(delete_count)
    casual_leaves = self.leave_credits.where("leave_id =?", Leave.casual_leave.id)
     delete_count.times do |i|
      casual_leaves[i].destroy
    end
  end

 def self.users_with_loss_of_pays(from, to)
  return LossOfPayInfo.joins(:attendance => :user)
  .where("Date(loss_of_pay_infos.created_at) >= ? AND Date(loss_of_pay_infos.created_at) <= ?", from, to)
  .collect(&:user)
 end 

#------------------------------------------------------------------------------------


  def self.import_user(comma_separated_values)
   require 'activerecord-import'
   record = comma_separated_values.split(",")
   user = User.new
   user.username = record[0]
   user.ecode    = record[1]
   user.name     = record[2]
   user.date_of_joining = record[3]
   user.bu    = record[4]
   user.email = record[5]
   user.current_contact      = record[6]
   user.emergency_contact_no = record[7]
   user.date_of_birth        = record[8]
   user.blood_group          = record[9]
   user.marriage_anniv_date  = record[10]
   user.pan               = record[11]
   user.card_no           = record[12]
   designation            = Designation.where("name=?", record[13]).first
   user.designation_id       = designation.try(:id)
   grade = Grade.where("name = ?", record[14]).first
   user.grade_id             = grade.try(:id)
   manager                = User.where("username = ?", record[15]).first
   user.manager_id        = manager.try(:id)
   confirmation           = Confirmation.where("name = ?", record[16]).first
   user.confirmation_id   = confirmation.try(:id)
   gender                 = Gender.where("name = ?", record[17]).first
   user.gender_id         = gender.try(:id)
   marital_status         = MaritalStatus.where("name = ?", record[18]).first
   user.marital_status_id = marital_status.try(:id)
   lta_option             = LtaOption.where("name = ?", record[19]).first
   user.lta_option_id = lta_option.try(:id)
   user.role = "admin"
   user.save!
   projects = record[20].split(",")
   projects.each do |p|
    project = Project.where("name = ?", p).first
    ProjectUser.create({user_id: user.id, project_id: project.id}) if project
   end
   earned_leaves_no = record[21]
   earned_leaves_created = []
   earned_leaves_no.to_i.times do |i|
    earned_leaves_created << LeaveCredit.new(user_id: user.id, 
                                             leave_id: Leave.earned_leave.id,
                                             leave_credited_date: Date.today,
                                             consumed: false)
   end
   LeaveCredit.import(earned_leaves_created)
   
   casual_leaves_no = record[22]
   casual_leaves_created = []
   casual_leaves_no.to_i.times do |i|
    casual_leaves_created << LeaveCredit.new(user_id: user.id, 
                                             leave_id: Leave.casual_leave.id,
                                             leave_credited_date: Date.today,
                                             consumed: false)
   end
   LeaveCredit.import(casual_leaves_created)

   sick_leaves_no = record[23]
   sick_leaves_created = []
   sick_leaves_no.to_i.times do |i|
    sick_leaves_created << LeaveCredit.new(user_id: user.id, 
                                             leave_id: Leave.sick_leave.id,
                                             leave_credited_date: Date.today,
                                             consumed: false)
   end
   LeaveCredit.import(sick_leaves_created)

  end


end
