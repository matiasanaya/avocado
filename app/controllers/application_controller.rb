class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  before_filter :require_login

  # Force signout to prevent CSRF attacks
  def handle_unverified_request
    sign_out
    super
  end

  private

  def require_login
    unless signed_in?
      store_location
      flash[:error] = 'Please sign in.' unless params[:action].eql?('root')
      redirect_to signin_url
    end
  end
end
