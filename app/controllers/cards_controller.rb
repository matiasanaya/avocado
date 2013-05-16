class CardsController < ApplicationController
  def root
    @card = current_user.cards.last
    render 'show'
  end

  def show
    @card = Card.find(params[:id])
  end
end
