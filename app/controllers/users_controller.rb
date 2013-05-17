class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  before_filter :correct_user,   only: [:show]

  def show
    @user = current_user
  end

  def new
  	@user = User.new
  end

	def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
    	flash[:success] = "Welcome to Avocado!"
      redirect_to @user
    else
      render 'new'
    end
	end

  private
    def correct_user
      # @user = User.find(params[:id])
      # redirect_to(signin_path) unless current_user
    end
end
