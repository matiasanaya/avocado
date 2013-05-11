class EmailSharesController < ApplicationController
  def show
  	@email_share = EmailShare.find_by_token params[:token]
    case @email_share.status
    when @email_share.card.status
      @status = 'perfect'
    else
      @status = 'outdated'
    end
  end

  def update
    email_share = EmailShare.find_by_token params[:token]
    email_share.update if email_share
  end
end
