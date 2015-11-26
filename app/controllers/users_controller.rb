class UsersController < ApplicationController
  def new
        
  end

  def create
      
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver	#Sending mail on signup.
      flash[:notice] = "Welcome to your Dashboard!"
      redirect_to "/"
    else
      flash[:alert] = "There was a problem creating your account. Please try again."
      redirect_to :back
    end
  end
  
  def change_password
    @user = current_user
  end
  
def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:notice] = "Welcome to your Dashboard!"
      redirect_to "/"
    else
      flash[:notice] = "Sorry!"
      redirect_to "/"
      end    
  end
 
  
  
  private
  def user_params
    
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
