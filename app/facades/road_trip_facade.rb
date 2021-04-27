class RoadTripFacade
  def self.get_road_trip(origin, destination)
    road_trip_data = MapQuestService.road_trip_data(origin, destination)
    destination_data = MapQuestService.location_data(destination)
    destination_coords = destination_data[:results][0][:locations][0][:latLng]
    forecast_data = WeatherService.get_forecast_by_coords(destination_coords)
    RoadTrip.new(road_trip_data, origin, destination, forecast_data)
  end
end
