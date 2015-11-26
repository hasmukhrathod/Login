class UsersController < ApplicationController

  skip_before_action :authorize, only: [:new, :create]
  def new
   
  end

  #Start users in an “unactivated” state.
    #When a user signs up, generate an activation token and corresponding activation digest.
    #Save the activation digest to the database, and then send an email to the user with a link containing the activation token and user’s email address.2
    #When the user clicks the link, find the user by email address, and then authenticate the token by comparing with the activation digest.
    #If the user is authenticated, change the status from “unactivated” to “activated”. 

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
  
  def edit
    @user = current_user
  end
  
def update
    @user = User.find(current_user.id)
    if @user.update(user_params)
      flash[:alert] = "Your profile has been updated.!"
      redirect_to "/"
    else
      flash[:notice] = "Sorry!"
      redirect_to "/"
      end    
  end
  def show
    @user = current_user
  end
  def index
    @users = User.paginate(page: params[:page])
  end
  
  
 
  
  
  private
  def user_params
    
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

end
