class LoginMailer < ApplicationMailer
  def send_when_not_login
    default to: "rto1728@gmail.com"
    mail(subject: "ログインしてないで")
  end
end
