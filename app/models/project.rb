class Project < ActiveRecord::Base
  has_many :users
  has_many :attendances, through: :users
end
