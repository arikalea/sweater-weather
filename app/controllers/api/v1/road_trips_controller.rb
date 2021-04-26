class Api::V1::RoadTripsController < ApplicationController
  def create
    origin = road_trip_params[:origin]
    destination = road_trip_params[:destination]
    user = User.find_by(api_key: road_trip_params[:api_key])
    if user
      road_trip = RoadTripFacade.get_road_trip(origin, destination, user)
    end 
  end

  private

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
