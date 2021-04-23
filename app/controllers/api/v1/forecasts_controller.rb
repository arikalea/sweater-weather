class Api::V1::ForecastsController < ApplicationController
  def show
    location = params[:location]

    geo_conn = Faraday.new(url: 'http://www.mapquestapi.com/') do |f|
      f.params[:key] = ENV['GEO_KEY']
    end

    geo_response = geo_conn.get('geocoding/v1/address') do |f|
      f.params[:location] = location
    end

    geo_json = JSON.parse(geo_response.body, symbolize_names: true)

    lat_long = geo_json[:results][0][:locations][0][:latLng]
    lat = lat_long[:lat]
    long = lat_long[:lng]

    # do the same thing with weather api 
  end
end
