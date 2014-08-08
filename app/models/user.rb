class User < ActiveRecord::Base
  devise :ldap_authenticatable, :rememberable, :trackable

  validates :username, presence: true
  belongs_to :emp_type
  belongs_to :designation
  belongs_to :grade
  belongs_to :gender
  belongs_to :project
  belongs_to :confirmation
  belongs_to :status
  belongs_to :location
  belongs_to :marital_status
  belongs_to :lta_option
  belongs_to :med_reimb_option
  belongs_to :manager, class_name: "User", foreign_key: :manager_id
  has_many :leave_credits
  has_many :attendances
end
