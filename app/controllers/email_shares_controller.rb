class EmailSharesController < ApplicationController  
  skip_before_filter :require_login, :only => [:show, :update]

  def index
    @email_shares = []
    if params[:use_case]
      cards = [current_user.card_with_use_case(params[:use_case])]
    else
      cards = current_user.cards
    end
    cards.each { |card| @email_shares << card.email_shares }
    @email_shares.flatten!
  end

  def awesome_index
    card = current_user.card_with_use_case(params[:use_case])
    @last_shares = []
    crawled_emails = []
    email_shares = EmailShare.where card_id: card
    email_shares.each do |share|
      @last_shares << EmailShare.where(card_id: card.id).last if !crawled_emails.include?(share.email)
      crawled_emails << share.email
    end
  end

  def show
  	@email_share = EmailShare.find_by_token(params[:token])
    if @email_share
      case @email_share.status
      when @email_share.card.status
        @status = 'perfect'
      else
        @status = 'outdated'
      end
    else
      render text: 'Invalid Request'
    end
  end

  def new
    @email_share = EmailShare.new
  end

  def create
    @email_share = EmailShare.new(params[:email_share])
    if @email_share.card.belongs_to?(current_user)
      if @email_share.save
        @email_share.email_card
        flash[:success] = "Successfully shared with #{@email_share.email}!"
        redirect_to cards_path(@email_share.card)
      else
        flash[:alert] = "Failed to share with #{@email_share.email}!"
        redirect_to cards_path(@email_share.card)
      end
    else
      render text: 'Invalid Request'
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
