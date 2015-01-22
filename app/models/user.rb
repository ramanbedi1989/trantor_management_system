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
end
