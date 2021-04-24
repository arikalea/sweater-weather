class Api::V1::ForecastsController < ApplicationController
  def show
    location = params[:location]
    forecast_data = ForecastFacade.get_forecast(location)
    # render json: forecast_data
    data = render json: ForecastSerializer.new(forecast_data)
  end
end
