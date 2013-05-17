class CardsController < ApplicationController
  def root
    @card = current_user.card_with_use_case 'business'
    render 'show'
  end

  def show
    @card = Card.find(params[:id])
    if !@card || !@card.belongs_to?(current_user)
      redirect_to :root
    end
  end
end
