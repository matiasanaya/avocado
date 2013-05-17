class EmailSharesController < ApplicationController  
  skip_before_filter :require_login, :only => [:show, :update]

  def index
    @email_shares = EmailShare.all
  end

  def show
  	@email_share = EmailShare.find_by_token params[:token]
    case @email_share.status
    when @email_share.card.status
      @status = 'perfect'
    else
      @status = 'outdated'
    end
  end

  def new
    @email_share = EmailShare.new
  end

  def create
    @email_share = EmailShare.new(params[:email_share])
    if @email_share.save
      @email_share.email_card
      flash[:success] = "Successfully shared with #{@email_share.email}!"
      redirect_to cards_path(@email_share.card)
    else
      flash[:alert] = "Failed to share with #{@email_share.email}!"
      redirect_to cards_path(@email_share.card)
    end
  end

  def update
    email_share = EmailShare.find_by_token params[:token]
    new_share = email_share.update if email_share
    new_share.email_card
  end

  def destroy
  end
end
