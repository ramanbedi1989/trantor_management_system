class EmployeeEmails < ActionMailer::Base
  default from: "DoNotReply_HROps@chd.trantorinc.com"
  add_template_helper(ApplicationHelper)

  def leave_applied(user, leave)
    @user = user
    @leave = leave
    mail(:to => "#{@user.name} <#{@user.email}>", :subject => "Leave Applied")
  end

  def loss_of_pay_reminder(user)
  	@user = user
  	@subject = "LMS : Loss of Pay Report"
  	mail(:to => "#{@user.name} <#{@user.email}>", :subject => @subject)
  end

  def loss_of_pay_reminder_manager(manager)
  	@manager = manager
  	@subject = "LMS : Approve Loss of Pay"
  	mail(:to => "#{@manager.name} <#{@manager.email}>", :subject => @subject)
  end

  def earned_leave_reminder(user)
  	@user = user
  	@subject = 'LMS: Maximum Earned Leave Balance Limit'
    mail(:to => "#{user.name} <#{user.email}>", :subject => @subject)
  end


  def approval_leave_request_email_to_manager(user, leave_info)
    @user = user
    @manager = user.manager
    @leave_info = leave_info
    @leave_type = leave_info.leave_credits.collect(&:name).to_sentence
    @subject = "LMS : Leave Approval Required"
    mail(:to => "#{@manager.name} <#{@manager.email}>", :subject => @subject)
  end

  def cancellation_of_approved_leave_request_to_manager(user, leave_info)
    @user = user
    @manager = user.manager
    @leave_info = leave_info
    @leave_type = leave_info.leave_credits.collect(&:name).to_sentence
    @subject = "LMS : Leave Cancellation Approval Required"
    mail(:to => "#{@manager.name} <#{@manager.email}>", :subject => @subject)
  end

end
