class WeatherService
  def self.get_forecast_by_coords(coordinates)
    forecast_response = conn.get('/data/2.5/onecall') do |f|
      f.params[:lat] = coordinates[:lat]
      f.params[:lon] = coordinates[:lng]
      f.params[:exclude] = 'minutely, alerts'
      f.params[:units] = 'imperial'
    end
    parse(forecast_response)
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.openweathermap.org') do |f|
      f.params[:appid] = ENV['WEATHER_KEY']
    end
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
