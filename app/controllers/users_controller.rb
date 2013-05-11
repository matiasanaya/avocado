class UsersController < ApplicationController
  before_filter :name_into_id
  before_filter :signed_in_user, only: [:show]
  before_filter :correct_user,   only: [:show]

  def show
    @user = User.find(params[:id])
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

    def name_into_id
      temp_user = User.find_by_name(params[:name]) if params[:name]
      params[:id] ||= temp_user.id if temp_user
    end

    def signed_in_user
      unless signed_in?
        store_location
        redirect_to signin_url, notice: "Please sign in."
      end
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
end
