class SessionsController < ApplicationController
  def new

  end
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      # login the user and redirect to the users profile
      log_in(user)
      # Only remember the user when the remember_me checkbox is checked otherwise
      # forget the user
      params[:session][:remember_me] == '1' ? remember(user) : forget(user)
      redirect_to user
    else
      # create an error message
      flash.now[:danger]='Invalid email/password combination'
      render 'new'
    end
  end
  def destroy
    # Only log out when user to log out is available 
    log_out if logged_in?
    redirect_to root_path
  end
end
