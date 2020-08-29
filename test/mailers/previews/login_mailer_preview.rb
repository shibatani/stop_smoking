# Preview all emails at http://localhost:3000/rails/mailers/login_mailer
class LoginMailerPreview < ActionMailer::Preview

  # Preview this email at http://localhost:3000/rails/mailers/login_mailer/send_when_not_login
  def send_when_not_login
    LoginMailer.send_when_not_login
  end

end
