class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = 'User created!'
      redirect_to user_path(@user)
    elsif params[:password] != params[:password_confirmation]
      flash[:alert] = 'Password and password confirmation do not match'
      redirect_to '/register'
    else
      flash[:alert] = "#{user_params[:email]} has already been taken, please try another email address."
      redirect_to '/register'
    end
  end

  def discover
    @user = User.find(params[:id])
  end

  def login_form
  end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to user_path(user)
    else
      flash[:error] = 'Sorry, your credentials are bad.'
      render '/users/login_form'
    end
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
