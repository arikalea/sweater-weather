class Api::V1::ForecastsController < ApplicationController
  def show
    location = params[:location]

    geo_conn = Faraday.new(url: 'http://www.mapquestapi.com') do |f|
      f.params[:key] = ENV['GEO_KEY']
    end

    geo_response = geo_conn.get('/geocoding/v1/address') do |f|
      f.params[:location] = location
    end

    geo_json = JSON.parse(geo_response.body, symbolize_names: true)

    lat_long = geo_json[:results][0][:locations][0][:latLng]
    lat = lat_long[:lat]
    long = lat_long[:lng]

    forecast_conn = Faraday.new(url: 'https://api.openweathermap.org') do |f|
      f.params[:appid] = ENV['WEATHER_KEY']
    end

    forecast_response = forecast_conn.get('/data/2.5/onecall') do |f|
      f.params[:lat] = lat
      f.params[:lon] = long
      f.params[:exclude] = 'minutely, alerts'
    end

    forecast_json = JSON.parse(forecast_response.body, symbolize_names: true)
    current_forecast = CurrentForecast.new(forecast_json)
    require "pry";binding.pry
    # render json: forecast_json
  end
end
