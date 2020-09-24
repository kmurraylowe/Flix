class UsersController < ApplicationController

before_action :require_signin, except: [:new, :create]
#in order they should be run, executed top to bottom
before_action :require_correct_user, only:[:edit, :update]
before_action :require_admin, only: [:destroy]



def index
@users = User.not_admins
end

def show
@user = User.find_by!(slug: params[:id])
@reviews = @user.reviews
@favorite_movies = @user.favorite_movies
end

def new
    @user = User.new
end

def create 
   @user = User.new(user_params)
   if @user.save
    session[:user_id] = @user.id
    redirect_to @user, notice: "User created"
   else
    render :new 
   end
end

def edit
    #@user = User.find(params[:id])
end

def update
    #@user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to @user, notice: "Account successfully updated!"
    else
      render :edit
    end
  end

  def destroy
    @user = User.find_by!(slug: params[:id])
    @user.destroy
    redirect_to root_url, alert: " Account successfully deleted"
  end






private

def user_params
    params.require(:user).
      permit(:name, :email, :password, :password_confirmation, :username)
  end
    
 def require_correct_user
 @user = User.find_by!(slug: params[:id])
  redirect_to root_url unless current_user?(@user)
 end




end
