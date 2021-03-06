class Api::V1::ForecastController < ApplicationController
  before_action :validate_params

  def index
    location = params[:location]
    forecast_data = ForecastFacade.get_forecast(location)
    render json: ForecastSerializer.new(forecast_data)
  end

  private

  def validate_params
    render json: { error: 'Your parameters are bad' }, status: :bad_request if params[:location].blank?
  end
end
