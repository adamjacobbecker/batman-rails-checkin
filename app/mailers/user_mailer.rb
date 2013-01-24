class UserMailer < ActionMailer::Base
  default from: "ad@mbecker.cc"

  def invite_email(to_email, from_user, project)
    @to_email = to_email
    @from_user = from_user
    @project = project
    mail(to: to_email, subject: "#{from_user.name} has invited you to MorningCheckin")
  end
end
