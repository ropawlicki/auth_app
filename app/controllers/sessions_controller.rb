class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(username: params[:username])
    if @user
      if @user.failed_signin_attempts >= 3
        flash[:warning] = 'Too many sign in attempts. Account blocked.'
        redirect_to signin_path and return
      elsif @user.password == params[:password]
        flash[:success] = 'Signed in'
        @user.update(failed_signin_attempts: 0) if @user.failed_signin_attempts.positive?
        redirect_to index_path and return
      end
      @user.increment!(:failed_signin_attempts)
    end
    flash[:warning] = 'Invalid credentials'

    redirect_to signin_path
  end

  def destroy
    flash[:success] = 'Signed out'
    redirect_to signin_path
  end
end
