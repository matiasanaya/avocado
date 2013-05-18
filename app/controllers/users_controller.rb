class UsersController < ApplicationController
  skip_before_filter :require_login, :only => [:new, :create]
  before_filter :correct_user,   only: [:show]

  def show
    @user = current_user
  end

  def new
  	@user = User.new
    redirect_to :root if current_user
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
      @user = User.find_by_id(params[:id])
      redirect_to(:root) if !@user || !current_user?(@user)
    end
end
