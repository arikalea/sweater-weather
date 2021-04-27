class Api::V1::RoadTripsController < ApplicationController
  before_action :validate_params

  def create
    origin = road_trip_params[:origin]
    destination = road_trip_params[:destination]
    road_trip = RoadTripFacade.get_road_trip(origin, destination)
    render json: RoadTripSerializer.new(road_trip), status: 201
  end

  private

  def validate_params
    if request.body.read.blank?
      render json: { error: user.errors.full_messages.to_sentence }, status: :bad_request
    else
      params = JSON.parse(request.body.read, symbolize_names: true)
      if params[:origin].blank? || params[:destination].blank?
        render json: { error: user.errors.full_messages.to_sentence }, status: :bad_request
      elsif !User.find_by(api_key: road_trip_params[:api_key])
        render json: { error: user.errors.full_messages.to_sentence }, status: :unauthorized
      end
    end
  end

  def road_trip_params
    params.permit(:origin, :destination, :api_key)
  end
end
