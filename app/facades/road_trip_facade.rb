class RoadTripFacade
  def self.get_road_trip(origin, destination, user)
    road_trip_data = MapQuestService.road_trip_data(origin, destination)
    RoadTrip.new(road_trip_data)
  end
end
