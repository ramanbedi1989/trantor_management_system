class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :read, :events, :leaves, :cancel_leaves_partial, :cancel_leaves, :request_comp_off, :comp_offs, to: :user_leave_actions
    alias_action :read, :leave_approval, :compoff_approval, to: :manager_actions

    user ||= User.new
    
    if user.role? :admin
      can :access, :rails_admin       # only allow admin users to access Rails Admin
      can :dashboard
      can :manage, :all
    elsif user.role? :manager
      can :user_leave_actions, User do |b_user|
        b_user == user
      end
      can :manager_actions, User do |b_user|
        b_user == user
      end
    elsif user.role? :employee
      can :user_leave_actions, User do |b_user|
        b_user == user
      end
    end
  end
end
