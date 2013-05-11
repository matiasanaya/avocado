class EmailSharesController < ApplicationController
  def show
  	@email_share = EmailShare.find_by_token params[:token]
    binding.pry
    case @email_share.status
    when @email_share.card.status
      @email_share.status = 'perfect'
    when 'Invalid'
      # Nothing to do
    else
      @email_share.status = 'outdated'
    end
  end

  def update
    @email_share = EmailShare.find_by_token params[:token]
    @email_share.update if @email_share
  end
end
