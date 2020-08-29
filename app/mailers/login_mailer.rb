class LoginMailer < ApplicationMailer
  def send_when_not_login
    mail to: "rto1728@gmail.com", subject: "ログインしてないで"
    binding.pry
  end
end
