class Api::V1::BackgroundsController < ApplicationController
  before_action :validate_params

  def show
    location = params[:location]
    background_data = BackgroundFacade.get_background(location)
    render json: ImageSerializer.new(background_data)
  end

  private

  def validate_params
    if params[:location].blank?
      render json: { error: 'Your parameters are bad' }, status: :bad_request
    end
  end
end
