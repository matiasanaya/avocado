class SessionsController < ApplicationController
	skip_before_filter :require_login, :only => [:new, :create]

  def new
    redirect_to :root if current_user
  end

  def create
  	user = User.find_by_email(params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_back_or cards_path(user.card_with_use_case('business'))
    else
      flash.now[:error] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
  	sign_out
    redirect_to signin_url
  end
end
