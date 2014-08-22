class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if @user
      leave_bal = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ?", @user.id, false).group("leaves.name").count
      @leave_name = []
      @leave_balance = []
      leave_bal.each do |k,v|
        @leave_name << k
        @leave_balance << v
      end
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
      Attendance.where("user_id = ? and attendance_date >= ? and attendance_date <= ?", user.id, from_date, to_date).each do |a|
        events << Event.new(
          id: Event.uniq_id(a.class.to_s, a.id),
          title: (a.present? ? "Present" : "Absent"), 
          class: (a.present? ? "event-success" : "event-inverse"),
          start: Event.day_start_to_milliseconds(a.attendance_date),
          end: Event.day_end_to_milliseconds(a.attendance_date)
          )
        if a.leave_credit_id
          leave_credit = a.leave_credit
          if leave_credit.approved?
            leave_status = "Approved"
          elsif leave_credit.rejected?
            leave_status = "Rejected"
          else
            leave_status = "Pending"
          end
          events << Event.new(
            id: Event.uniq_id(leave_credit.class.to_s, leave_credit.id),
            title: "#{leave_credit.leave.name} - #{leave_status}", 
            class: "event-warning",
            url: users_cancel_leaves_partial_path(user.id, leave_credit.id),
            start: Event.day_start_to_milliseconds(a.attendance_date),
            end: Event.day_end_to_milliseconds(a.attendance_date),
            modal: "#cancelLeaveModal",
            modal_type: "ajax"
            )
        end
        if a.loss_of_pay_id
          loss_of_pay = a.loss_of_pay
          events << Event.new(
            id: Event.uniq_id(loss_of_pay.class.to_s, a.id),
            title: "#{loss_of_pay.name}", 
            class: "event-important",
            start: Event.day_start_to_milliseconds(a.attendance_date),
            end: Event.day_end_to_milliseconds(a.attendance_date)
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
    date_to = params[:date_to].to_date
    check_status = (params[:check_status] == "true")
    reason = params[:reason];
    selected_option = User::ALLOWED_LEAVES.index(params[:leave_type])
    if user && date_from && date_to && selected_option
      dates = (date_from..date_to).to_a
      leaves_deducted = Hash.new(0)
      leave_dates = dates.dup
      if(LeaveCredit.joins(:attendance).where("leave_credits.user_id = ? and attendances.attendance_date IN (?) and leave_credits.rejected = ?", user.id, dates, false).count > 0)
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
          if dates.include? next_day
            prev_day = d - 1
            prev_day -= 1 while (Holiday.find_by(date: prev_day, day_shift: user.day_shift))
            if !(dates.include?(prev_day)) 
              leave_dates.delete(d)
              leave_dates.delete(d + 1)
            end
          end
        elsif d.wday == 0
          next_day = d + 1
          next_day += 1 while (Holiday.find_by(date: next_day, day_shift: user.day_shift))
          if dates.include? next_day
            prev_day = d - 2
            prev_day -= 1 while (Holiday.find_by(date: prev_day, day_shift: user.day_shift))
            if !(dates.include?(prev_day)) 
              leave_dates.delete(d)
              leave_dates.delete(d - 1)
            end
          end
        end
      end 
      case selected_option
      when 0
        comp_offs = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][5]).order("date(leave_credited_date)")
        casual_leaves = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][1]).order("date(leave_credited_date)")
        earned_leaves = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][2]).order("date(leave_credited_date)")
        comp_offs.each do |co|
          deduct_leaves(leave_dates, co, leaves_deducted, user.id, check_status, date_from, date_to)
        end
        if(leave_dates.count > 4)
          earned_leaves.each do |el|
            deduct_leaves(leave_dates, el, leaves_deducted, user.id, check_status, date_from, date_to)
          end
          casual_leaves.each do |cl|
            deduct_leaves(leave_dates, cl, leaves_deducted, user.id, check_status, date_from, date_to)
          end
        else
          casual_leaves.each do |cl|
            deduct_leaves(leave_dates, cl, leaves_deducted, user.id, check_status, date_from, date_to)
          end
          earned_leaves.each do |el|
            deduct_leaves(leave_dates, el, leaves_deducted, user.id, check_status, date_from, date_to)
          end
        end
        deduct_loss_of_pay(leave_dates, leaves_deducted, user.id, check_status, date_from, date_to) if leave_dates.count > 0
      when 1
        comp_offs = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][5]).order("date(leave_credited_date)")
        sick_leaves = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][0]).order("date(leave_credited_date)")
        earned_leaves = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][2]).order("date(leave_credited_date)")
        casual_leaves = LeaveCredit.joins(:leave).where("user_id = ? and consumed = ? and leaves.name = ?", user.id, false, SeedData["leaves"][1]).order("date(leave_credited_date)")
        comp_offs.each do |co|
          deduct_leaves(leave_dates, co, leaves_deducted, user.id, check_status, date_from, date_to)
        end
        sick_leaves.each do |sl|
          deduct_leaves(leave_dates, sl, leaves_deducted, user.id, check_status, date_from, date_to)
        end
        earned_leaves.each do |el|
          deduct_leaves(leave_dates, el, leaves_deducted, user.id, check_status, date_from, date_to)
        end
        casual_leaves.each do |cl|
          deduct_leaves(leave_dates, cl, leaves_deducted, user.id, check_status, date_from, date_to)
        end
        deduct_loss_of_pay(leave_dates, leaves_deducted, user.id, check_status, date_from, date_to) if leave_dates.count > 0
      when 2
        leave_dates.each do |d| 
          unless check_status
            leave_credit = LeaveCredit.create(user_id: user.id, leave_id: Leave.where("name = ?",SeedData["leaves"][4]).first.id, leave_applied_date: Time.now, leave_credited_date: Time.now, consumed: true, reason: reason)
            attendance = Attendance.where(user_id: user.id, attendance_date: d).first_or_initialize
            attendance.leave_credit_id = leave_credit.id
            attendance.save
          end
          leaves_deducted[SeedData["leaves"][4]] += 1
        end
      end
      if check_status
        render json: leaves_deducted
      else
        redirect_to users_show_path(user.id)
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
    @leave_credit = LeaveCredit.find(params[:leave_id])
    render partial: 'cancel_leaves', format: 'js'
  end

  def cancel_leaves
    @user = User.find(params[:id])
    @leave_credit = LeaveCredit.find(params[:leave_id])
  end

  protected 

  def deduct_leaves(dates, leave, leaves_deducted, user_id, check_status)
    if(dates.count > 0)
      unless check_status
        attendance = Attendance.where(user_id: user_id, attendance_date: dates.first).first_or_initialize
        attendance.leave_credit_id = leave.id
        leave.consumed = true
        leave.save
        attendance.save
      end
      leaves_deducted[leave.leave.name] += 1
      dates.delete(dates.first)
    end
  end

  def deduct_loss_of_pay(leave_dates, leaves_deducted, user_id, check_status)
    leave_dates.each do |ld|
      unless check_status
        attendance = Attendance.where(user_id: user_id, attendance_date: ld).first_or_initialize
        attendance.loss_of_pay_id = LossOfPay.where(name: SeedData["loss_of_pays"][0]).first.id
        attendance.save
      end
      leaves_deducted[SeedData["loss_of_pays"][0]] += 1
    end
  end

  def adjacent_leave_exist(dates,user)
    min_date = dates.min - 1
    max_date = dates.max + 1
    min_date -= 1 while(min_date.wday == 0 || min_date.wday == 6 || Holiday.find_by(date: min_date, day_shift: user.day_shift))
    max_date += 1 while(max_date.wday == 0 || max_date.wday == 6 || Holiday.find_by(date: max_date, day_shift: user.day_shift))
    if(LeaveCredit.joins(:attendance).where("leave_credits.user_id = ? and attendances.attendance_date = ? and leave_credits.rejected = ?", user.id, min_date, false).count > 0)
      true
    elsif(LeaveCredit.joins(:attendance).where("leave_credits.user_id = ? and attendances.attendance_date = ? and leave_credits.rejected = ?", user.id, max_date, false).count > 0)
      true
    else
      false      
    end
  end
end
