class ManagersController < ApplicationController
  authorize_resource :class => false
  def show
    manager = User.find(params[:manager_id])
    if manager
      @employee_leaves = LeaveInfo.includes([:user, :leave_credits, :loss_of_pay_infos]).where("users.manager_id = ? and cancelled = ? and cancel_request = ?", manager.id, false, false).references(:user).order("DATE(leave_infos.created_at) DESC")
      @employee_compoff_requests = CompOffRequest.includes(:user).where("users.manager_id = ?", manager.id).references(:user).order("DATE(comp_off_requests.created_at) DESC")
      @leave_cancel_requests = LeaveInfo.includes([:user, :leave_credits, :loss_of_pay_infos]).where("users.manager_id = ? and cancelled = ? and cancel_request = ?", manager.id, false, true).references(:user).order("DATE(leave_infos.created_at) DESC")
    else
      redirect_to users_show_path(current_user.id), alert: "Manager not found."
    end
  end

  def leave_approval
    manager = User.find(params[:manager_id])  
    approval_type = params[:approval_type] == "true"
    @leave_data = {}
    if manager
      leave = LeaveInfo.find(params[:leave_id])
      if leave && leave.user.manager == manager
        @leave_data[:leave] = leave
        if approval_type
          leave.approved = true
          @leave_data[:approval_type] = true
        else
          leave.rejected = true
          @leave_data[:approval_type] = false
        end
        if leave.save
          @leave_data[:success] = true
        else 
          @leave_data[:success] = false
        end
      else
        @leave_data[:success] = false
      end
    else
      @leave_data[:success] = false
    end
  end

  def compoff_approval
    manager = User.find(params[:manager_id])  
    approval_type = params[:approval_type] == "true"
    @compoff_data = {}
    if manager
      compoff = CompOffRequest.find(params[:compoff_id])
      if compoff && compoff.user.manager == manager
        @compoff_data[:compoff] = compoff
        if approval_type
          compoff.approved = true
          @compoff_data[:approval_type] = true
        else
          compoff.rejected = true
          @compoff_data[:approval_type] = false
        end
        if compoff.save
          if approval_type
            compoff.days.times do 
              LeaveCredit.create(user_id: compoff.user.id, leave_id: Leave.where(name: SeedData["leaves"][6]).first.id, leave_credited_date: Date.today, comp_off_request_id: compoff.id)
            end
          else
            compoff.leave_credits.destroy_all
          end
          @compoff_data[:success] = true
        else 
          @compoff_data[:success] = false
        end
      else
        @compoff_data[:success] = false
      end
    else
      @compoff_data[:success] = false
    end
  end

  def leave_cancellation
    manager = User.find(params[:manager_id])  
    if manager
      leave = LeaveInfo.find(params[:leave_id])
      if leave && leave.user.manager == manager
        leave.cancelled = true 
        if leave.save
          redirect_to managers_show_path(current_user.id), notice: "Leave cancelled successfully."
        else 
          redirect_to managers_show_path(current_user.id), alert: "Could not cancel leave."
        end
      else
        redirect_to managers_show_path(current_user.id), alert: "Could not cancel leave."
      end
    else
      redirect_to managers_show_path(current_user.id), alert: "Could not cancel leave."
    end
  end
end
