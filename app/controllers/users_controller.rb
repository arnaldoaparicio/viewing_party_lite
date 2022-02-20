class UsersController < ApplicationController
  def show
    if !current_user.nil?
      @user = User.find(current_user.id)
    else
      flash[:alert] = 'You must be logged in or registered to asccess dashboard'
    end
  end

  def new; end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'User created!'
      redirect_to '/dashboard'
    elsif params[:password] != params[:password_confirmation]
      flash[:alert] = 'Password and password confirmation do not match'
      redirect_to '/register'
    else
      flash[:alert] = "#{user_params[:email]} has already been taken, please try another email address."
      redirect_to '/register'
    end
  end

  def discover
    @user = User.find(current_user.id)
  end

  def login_form; end

  def login_user
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome, #{user.name}!"
      redirect_to '/dashboard'
    else
      flash[:error] = 'Sorry, your credentials are bad.'
      render '/users/login_form'
    end
  end

  # user logout
  def destroy
    reset_session
    current_user = nil
    redirect_to '/'
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end
end
