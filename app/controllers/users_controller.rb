class UsersController < ApplicationController
  load_and_authorize_resource
  skip_load_and_authorize_resource only: :info
  def show
    @user = User.find(params[:id])
    if @user
      full_day_leave_bal = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and half_day_leave = ?", @user.id, false, false).group("leaves.name").count
      half_day_leave_bal = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and half_day_leave = ?", @user.id, false, true).group("leaves.name").count
      full_day_leave_bal.default = 0
      half_day_leave_bal.default = 0
      leave_name = [SeedData["leaves"][0], SeedData["leaves"][1], SeedData["leaves"][2], SeedData["leaves"][6]]
      @leave_balance = {}
      leave_name.each do |name|
        @leave_balance[name] = full_day_leave_bal[name] + (half_day_leave_bal[name]/2.0) 
      end
    end
  end

  def info
    ecode = params[:ecode].downcase
    user = User.find_by(emp_id: ecode)
    if user
      render json: user, include: :emp_type, status: :ok
    else
      render json: {message: "Could not find user"}, status: :not_found
    end
  end

  def request_comp_off
    user = User.find(params[:id])
    no_days = params[:days]
    reason = params[:reason]
    if user && no_days && reason && (no_days.to_i > 0)
      comp_off = CompOffRequest.new(user_id: user.id, days: no_days, reason: reason, applied_date: Date.today)
      if comp_off.save
        redirect_to users_show_path(user.id), notice: "Compensatory Off requested successfully."
      else
        redirect_to users_show_path(user.id), alert: "Cannot apply Compensatory Off at the moment."
      end
    else
      redirect_to users_show_path(user.id), alert: "Invalid parameters."
    end
  end

  def comp_offs
    user = User.find(params[:id])
    if user
      @comp_offs = CompOffRequest.where(user_id: user.id)
    else
      redirect_to users_show_path(user.id), alert: "Invalid parameters."
    end
  end

  def events
    user = User.find(params[:id])
    from_date = Time.at(params[:from].to_i / 1000).to_date
    to_date = Time.at(params[:to].to_i / 1000).to_date - 1
    events = []
    if user && from_date && to_date
      Holiday.where("date >= ? and date <= ? and day_shift = ?", from_date, to_date, user.day_shift).all.each do |h|
        events << Event.new(id: Event.uniq_id(h.class.to_s, h.id), title: h.name, class: "event-info", start: Event.day_start_to_milliseconds(h.date), end: Event.day_end_to_milliseconds(h.date))
      end
      Attendance.includes([{ leave_credit: [:leave_info] }, :loss_of_pay_info ]).where("user_id = ? and attendance_date >= ? and attendance_date <= ?", user.id, from_date, to_date).each do |a|
        events << Event.new(
          id: Event.uniq_id(a.class.to_s, a.id),
          title: (a.present ? "Present" : "Absent"), 
          class: (a.present ? "event-success" : "event-inverse"),
          start: Event.day_start_to_milliseconds(a.attendance_date),
          end: Event.day_end_to_milliseconds(a.attendance_date)
          ) if a.attendance_date <= Date.today
        if(leave_credit = a.leave_credit)
          leave_info  =  leave_credit.leave_info
          if leave_info.approved?
            leave_status = "Approved"
          elsif leave_info.rejected?
            leave_status = "Rejected"
          else
            leave_status = "Pending"
          end
          half_day = leave_credit.half_day_leave?
          is_first_half = leave_credit.is_first_half?
          if half_day && is_first_half
            half_day_str = LeaveCredit::HALF_DAY_LEAVES[0]
          elsif half_day && !is_first_half
            half_day_str = LeaveCredit::HALF_DAY_LEAVES[1]
          else
            half_day_str = ""
          end
          events << Event.new(
            id: Event.uniq_id(leave_credit.class.to_s, leave_credit.id),
            title: "#{leave_credit.leave.name} #{half_day_str} - #{leave_status}", 
            class: "event-warning",
            url: users_cancel_leaves_partial_path(user.id, leave_credit.leave_info_id),
            start: Event.day_start_to_milliseconds(a.attendance_date, half_day_str),
            end: Event.day_end_to_milliseconds(a.attendance_date, half_day_str),
            modal: "#cancelLeaveModal",
            modal_type: "ajax"
            )
        end
        if(loss_of_pay_info = a.loss_of_pay_info)
          events << Event.new(
            id: Event.uniq_id(loss_of_pay_info.class.to_s, loss_of_pay_info.id),
            title: "#{loss_of_pay_info.loss_of_pay.name}", 
            class: "event-important",
            url: users_cancel_leaves_partial_path(user.id, loss_of_pay_info.leave_info_id),
            start: Event.day_start_to_milliseconds(a.attendance_date),
            end: Event.day_end_to_milliseconds(a.attendance_date),
            modal: "#cancelLeaveModal",
            modal_type: "ajax"
            )
        end
      end
      render json: {success: 1, result: events}
    else
      render json: {success: 0, result: []}
    end
  end

  def leaves
    user = User.find(params[:id])
    date_from = params[:date_from].to_date
    selected_option = User::ALLOWED_LEAVES.index(params[:leave_type])
    check_status = (params[:check_status] == "true")
    if selected_option == 5
      date_to = date_from.dup
      half_day_type = LeaveCredit::HALF_DAY_LEAVES.index(params[:half_day_type])
    elsif selected_option == 4
      if user.gender.name != SeedData["genders"][1]
        if check_status
          render json: { message: "Male employees cannot apply this leave." }, status: 400
        else
          redirect_to users_show_path(user.id), alert: "Male employees cannot apply this leave."
        end
        return
      end
      date_to = date_from + 83
    else
      date_to = params[:date_to].to_date
    end
    reason = params[:reason]
    if !check_status && reason.blank?
      redirect_to users_show_path(user.id), alert: "Reason is required."
      return
    end
    
    if user && date_from && date_to && selected_option
      dates = (date_from..date_to).to_a
      leaves_deducted = Hash.new(0)
      leave_dates = dates.dup
      if(LeaveCredit.joins(:attendance).where("leave_credits.user_id = ? and attendances.attendance_date IN (?)", user.id, dates).count > 0)
        if check_status
          render json: { message: "Leaves already applied in the present date range." }, status: 400
        else
          redirect_to users_show_path(user.id), alert: "Leaves already applied in the present date range."
        end
        return
      end
      if (selected_option < 2) && adjacent_leave_exist(dates,user)
        if check_status
          render json: { message: "Adjecent day leaves cannot be applied, please cancel the earlier leave and apply again." }, status: 400
        else
          redirect_to users_show_path(user.id), alert: "Adjecent day leaves cannot be applied, please cancel the earlier leave and apply again."
        end
        return
      end
      dates.each do |d| 
        if Holiday.find_by(date: d, day_shift: user.day_shift)
          leave_dates.delete(d)
        elsif d.wday == 6
          next_day = d + 2
          next_day += 1 while (Holiday.find_by(date: next_day, day_shift: user.day_shift))
          prev_day = d - 1
          prev_day -= 1 while (Holiday.find_by(date: prev_day, day_shift: user.day_shift))  
          unless dates.include?(next_day) and dates.include?(prev_day)
            leave_dates.delete(d)
            leave_dates.delete(d + 1)
          end
        elsif d.wday == 0
          next_day = d + 1
          next_day += 1 while (Holiday.find_by(date: next_day, day_shift: user.day_shift))
          prev_day = d - 2
          prev_day -= 1 while (Holiday.find_by(date: prev_day, day_shift: user.day_shift))
          unless dates.include?(next_day) and dates.include?(prev_day)
            leave_dates.delete(d)
            leave_dates.delete(d - 1)
          end
        end
      end
      @leave_info = LeaveInfo.create(user_id: user.id, date_from: date_from, date_to: date_to, reason: reason, leave_applied_date: Date.today) unless check_status
      case selected_option
      when 0
        comp_offs = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][6]).order("date(leave_credited_date)")
        casual_leaves = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][1]).order("date(leave_credited_date)")
        earned_leaves = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][2]).order("date(leave_credited_date)")
        comp_offs.each do |co|
          deduct_leaves(leave_dates, co, leaves_deducted, user.id, check_status)
        end
        if(leave_dates.count > 4)
          earned_leaves.each do |el|
            deduct_leaves(leave_dates, el, leaves_deducted, user.id, check_status)
          end
          casual_leaves.each do |cl|
            deduct_leaves(leave_dates, cl, leaves_deducted, user.id, check_status)
          end
        else
          casual_leaves.each do |cl|
            deduct_leaves(leave_dates, cl, leaves_deducted, user.id, check_status)
          end
          earned_leaves.each do |el|
            deduct_leaves(leave_dates, el, leaves_deducted, user.id, check_status)
          end
        end
        deduct_loss_of_pay(leave_dates, leaves_deducted, user.id, check_status) if leave_dates.count > 0
      when 1
        comp_offs = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][6]).order("date(leave_credited_date)")
        sick_leaves = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ? and half_day_leave = ?", user.id, false, SeedData["leaves"][0], false).order("date(leave_credited_date)")
        earned_leaves = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][2]).order("date(leave_credited_date)")
        casual_leaves = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][1]).order("date(leave_credited_date)")
        comp_offs.each do |co|
          deduct_leaves(leave_dates, co, leaves_deducted, user.id, check_status)
        end
        sick_leaves.each do |sl|
          deduct_leaves(leave_dates, sl, leaves_deducted, user.id, check_status)
        end
        earned_leaves.each do |el|
          deduct_leaves(leave_dates, el, leaves_deducted, user.id, check_status)
        end
        casual_leaves.each do |cl|
          deduct_leaves(leave_dates, cl, leaves_deducted, user.id, check_status)
        end
        deduct_loss_of_pay(leave_dates, leaves_deducted, user.id, check_status) if leave_dates.count > 0
      when 2
        leave_dates.each do |d| 
          unless check_status            
            attendance = Attendance.where(user_id: user.id, attendance_date: d).first_or_create
            LeaveCredit.create(user_id: user.id, leave_id: Leave.where("name = ?",SeedData["leaves"][4]).first.id, attendance_id: attendance.id, leave_credited_date: Date.today, consumed: true, leave_info_id: @leave_info)
          end
          leaves_deducted[SeedData["leaves"][4]] += 1
        end
      when 3
        leave_dates.each do |d| 
          unless check_status            
            attendance = Attendance.where(user_id: user.id, attendance_date: d).first_or_create
            LeaveCredit.create(user_id: user.id, leave_id: Leave.where("name = ?",SeedData["leaves"][5]).first.id, attendance_id: attendance.id, leave_credited_date: Date.today, consumed: true, leave_info_id: @leave_info)
          end
          leaves_deducted[SeedData["leaves"][5]] += 1
        end
      when 4
        dates.each do |d| 
          unless check_status            
            attendance = Attendance.where(user_id: user.id, attendance_date: d).first_or_create
            LeaveCredit.create(user_id: user.id, leave_id: Leave.where("name = ?",SeedData["leaves"][3]).first.id, attendance_id: attendance.id, leave_credited_date: Date.today, consumed: true, leave_info_id: @leave_info)
          end
          leaves_deducted[SeedData["leaves"][3]] += 1
        end
      when 5
        leave = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ? and half_day_leave = ?", user.id, false, SeedData["leaves"][0], true).order("date(leave_credited_date)").first
        if leave
          create_other_half = false
        else
          create_other_half = true
          leave = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][0]).order("date(leave_credited_date)").first
        end
        if leave
          unless check_status
            leave_dates.each do |d|
              attendance = Attendance.where(user_id: user.id, attendance_date: d).first_or_create
              leave.attendance_id = attendance.id 
              leave.consumed = true
              leave.leave_info_id = @leave_info.id
              leave.half_day_leave = true
              if half_day_type == 0
                leave.is_first_half = true
              elsif half_day_type == 1
                leave.is_first_half = false
              end
              if create_other_half
                other_leave = LeaveCredit.create(user_id: user.id, leave_id: leave.leave.id, leave_credited_date: leave.leave_credited_date, consumed: false, half_day_leave: true, is_first_half: !leave.is_first_half, other_half_leave_id: leave.id) 
                leave.other_half_leave_id = other_leave
              end
              leave.save
            end
          end
          leaves_deducted[leave.leave.name] += 0.5
        else
          if check_status
            render json: { message: "No sick leaves left." }, status: 400
          else
            redirect_to users_show_path(user.id), alert: "No sick leaves left."
          end
          return;
        end
      end
      EmployeeEmails.approval_leave_request_email_to_manager(user, leave, @leave_info)                  ##Mail to manager for approval
      if check_status
        render json: leaves_deducted
      else
        EmployeeEmails.leave_applied(user, @leave_info).deliver
        redirect_to users_show_path(user.id), notice: "Leave successfully deducted."
      end
    else
      if check_status
        render json: { message: "Invalid parameters." }, status: 400
      else
        redirect_to users_show_path(user.id), alert: "Invalid parameters."
      end
    end
  end

  def cancel_leaves_partial
    @user = User.find(params[:id])
    @leave_deducted = LeaveInfo.find_by(user_id: params[:id], id: params[:leave_id])
    if @user && @leave_deducted
      render partial: 'cancel_leaves', format: 'js'
    else
      render json: {message: "Invalid request"}, status: 400
    end
  end

  def cancel_leaves
    user = User.find(params[:id])
    leave_info = LeaveInfo.find_by(user_id: params[:id], id: params[:leave_info_id])
    if user && leave_info
      if !leave_info.approved && !leave_info.rejected
        leave_info.cancelled = true
        message = "Your leaves have been canceled sucessfully."
      else
        leave_info.cancel_request = true
        message = "Your leaves have been requested for cancellation."
      end
      if leave_info.save
        redirect_to users_show_path(user.id), notice: message
      else
        redirect_to users_show_path(user.id), alert: "Could not cancel leave."
      end
    else
      redirect_to users_show_path(user.id), alert: "Invalid request, could not cancel leave."
    end
  end

  protected 

  def deduct_leaves(dates, leave, leaves_deducted, user_id, check_status)
    if(dates.count > 0)
      unless check_status
        attendance = Attendance.where(user_id: user_id, attendance_date: dates.first).first_or_create
        leave.attendance_id = attendance.id 
        leave.consumed = true
        leave.leave_info_id = @leave_info.id
        leave.save
      end
      leaves_deducted[leave.leave.name] += 1
      dates.delete(dates.first)
    end
  end

  def deduct_loss_of_pay(leave_dates, leaves_deducted, user_id, check_status)
    leave_dates.each do |ld|
      unless check_status
        attendance = Attendance.where(user_id: user_id, attendance_date: ld).first_or_create
        LossOfPayInfo.create(attendance_id: attendance.id, loss_of_pay_id: LossOfPay.where(name: SeedData["loss_of_pays"][0]).first.id, leave_info_id: @leave_info.id)      
      end
      leaves_deducted[SeedData["loss_of_pays"][0]] += 1
    end
  end

  def adjacent_leave_exist(dates,user)
    min_date = dates.min - 1
    max_date = dates.max + 1
    min_date -= 1 while(min_date.wday == 0 || min_date.wday == 6 || Holiday.find_by(date: min_date, day_shift: user.day_shift))
    max_date += 1 while(max_date.wday == 0 || max_date.wday == 6 || Holiday.find_by(date: max_date, day_shift: user.day_shift))
    if(LeaveCredit.joins(:attendance).where("leave_credits.user_id = ? and attendances.attendance_date = ? and leave_credits.half_day_leave = ?", user.id, min_date, false).count > 0)
      true
    elsif(LeaveCredit.joins(:attendance).where("leave_credits.user_id = ? and attendances.attendance_date = ? and leave_credits.half_day_leave = ?", user.id, max_date, false).count > 0)
      true
    else
      false      
    end
  end
end
