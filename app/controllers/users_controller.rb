class UsersController < ApplicationController

  skip_before_action :authorize, only: [:new, :create]
  before_action :admin_user, only: :destroy
  def new
   @user=User.new
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
      redirect_to "/", notice: 'User was successfully created.'
    else
      render :new
      #redirect_to new_user_url, error: "There are some errors: Please go throuth it."
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
  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User deleted"
    redirect_to users_url
  end
  
  
 
  
  
  private
  def user_params
    
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
  
  def admin_user
      redirect_to ("/") unless current_user.admin?
    end

end
