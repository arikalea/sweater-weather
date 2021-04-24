class Forecast
  attr_reader :id,
              :location,
              :current,
              :hourly,
              :daily

  def initialize(location, data)
    @id = nil
    @location = location
    @current = CurrentForecast.new(data[:current])
    @hourly = HourlyForecast.eight_hour(data[:hourly])
    @daily = DailyForecast.next_five_days(data[:daily])
  end
end
