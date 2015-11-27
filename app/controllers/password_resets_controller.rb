class PasswordResetsController < ApplicationController
  
   skip_before_action :authorize, only: [:new, :edit, :create]
  def new
  end

  def edit
  end
  
  def create
    @user = User.find_by(email: params[:password_reset][:email])
    if @user
      @user.create_reset_digest
      @user.send_password_reset_email
      flash[:info] = "Email sent with password reset instructions"
      redirect_to "/"
    else
      flash.now[:danger] = "Email address not found"
      render 'new'
    end
  end

  
  
end
