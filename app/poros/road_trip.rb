class RoadTrip
  attr_reader :start_city,
              :end_city,
              :travel_time,
              :weather_at_eta

  def initialize(road_trip_data, origin, destination, forecast_data)
    @start_city = origin
    @end_city = destination
    @travel_time = get_travel_time(road_trip_data)
    @weather_at_eta = get_weather(road_trip_data, forecast_data)
  end

  def get_travel_time(road_trip_data)
    if road_trip_data[:info][:messages].blank?
      time = road_trip_data[:route][:formattedTime].split(":")
      "#{time[0]} hours, #{time[1]} minutes"
    else
      "This route is impossible."
    end
  end

  def get_weather(road_trip_data, forecast_data)
    return {} if !road_trip_data[:info][:messages].blank?
    arrival_time = ((road_trip_data[:route][:time] / 60) / 60).round
    arrival_weather = forecast_data[:hourly][arrival_time]
      {
        temperature: arrival_weather[:temp],
        conditions: arrival_weather[:weather][0][:description]
      }
  end
end
