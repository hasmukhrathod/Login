class UserMailer < ApplicationMailer

  def welcome_email(user)
      @user = user     
      mail(:to => user.email, :subject => 'Thanks for signing up for our amazing app')
    end
    def password_reset(user)
    @user = user
    mail to: user.email, subject: "Password reset"
  end
end
