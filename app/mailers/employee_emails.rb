class EmployeeEmails < ActionMailer::Base
  default from: "Team HR"
  add_template_helper(ApplicationHelper)

  def leave_applied(user, leave)
    @user = user
    @leave = leave
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Leave Applied")
  end

  def earned_leave_reminder(user)
  	@user = user
  	@subject = 'LMS: Maximum Earned Leave Balance Limit'
    mail(:to => "#{user.name} <#{user.email}>", :subject => @subject)
  end

end
