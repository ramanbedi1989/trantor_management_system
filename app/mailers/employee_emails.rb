class EmployeeEmails < ActionMailer::Base
  default from: "Team HR"
  add_template_helper(ApplicationHelper)

  def leave_applied(user, leave)
    @user = user
    @leave = leave
    mail(:to => "#{user.name} <#{user.email}>", :subject => "Leave Applied")
  end
end
