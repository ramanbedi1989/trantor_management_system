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
  has_many :project_users
  has_many :projects, :through => :project_users
  belongs_to :confirmation
  belongs_to :status
  belongs_to :location
  belongs_to :marital_status
  belongs_to :lta_option
  belongs_to :med_reimb_option
  belongs_to :manager, class_name: "User", foreign_key: :manager_id
  has_many :leave_credits
  has_many :attendances
  has_many :leave_infos

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

  # INCREMENT UPTO 36
  MAX_EARNED_LEAVES = 36
  def increment_earned_leaves(increment_by=1)
    earned_leaves = self.leave_credits.where("leave_id =?", Leave.earned_leave.id).count
    return false if earned_leaves == MAX_EARNED_LEAVES
    left_leaves = MAX_EARNED_LEAVES - earned_leaves
    if increment_by <= left_leaves
      IncrementLeaves.increment_earned_leaves([self], increment_by)
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


end
