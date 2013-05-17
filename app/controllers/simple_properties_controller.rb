class SimplePropertiesController < ApplicationController
  def new
    @prop = SimpleProperty.new card_id: params[:card_id]
    unless @prop.card && @prop.card.belongs_to?(current_user)
      flash[:alert] = 'Invalid Request'
      redirect_to :root
    end
  end

  def create
    @prop = SimpleProperty.new(params[:simple_property])
    if @prop.card && @prop.card.belongs_to?(current_user)
      if @prop.save
        flash[:success] = "Property added!"
        redirect_to cards_path(@prop.card)
      else
        render 'new'
      end
    else
      flash[:alert] = 'Invalid Request'
      redirect_to :root
    end
  end

  def destroy
    @prop = SimpleProperty.find(params[:id])
    if @prop.card && @prop.card.belongs_to?(current_user)
      @prop.destroy
      redirect_to cards_path(@prop.card)
    else
      flash[:alert] = 'Invalid Request'
      redirect_to :root
    end
  end
end
