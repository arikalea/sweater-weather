class Api::V1::BackgroundsController < ApplicationController
  def show
    location = params[:location]
    background_data = BackgroundFacade.get_background(location)
    render json: BackgroundSerializer.new(background_data)
  end
end
