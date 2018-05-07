class UserSignupMailer < ApplicationMailer
  default :from => 'noreply@foo.com'
 
  def send_signup_email(user)
    @user = user
    mail(:to => @user.email, :subject => 'Welcome to Fashion Police!')
  end
end
