class SimplePropertiesController < ApplicationController
  def new
    @prop = SimpleProperty.new card_id: params[:card_id] 
  end

  def create
    @prop = SimpleProperty.new(params[:simple_property])
    if @prop.save
      flash[:success] = "Property added!"
      redirect_to cards_path(@prop.card)
    else
      render 'new'
    end
  end

  def destroy
    @prop = SimpleProperty.find(params[:id]).destroy
    redirect_to cards_path(@prop.card)
  end
end
