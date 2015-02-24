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

end
