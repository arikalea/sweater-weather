class MapQuestService
  def self.location_data(location)
    mq_response = conn.get('/geocoding/v1/address') do |f|
      f.params[:location] = location
    end
    parse(mq_response)
  end

  def self.road_trip_data(origin, destination)
    mq_response = conn.get('/directions/v2/route?') do |f|
      f.params[:from] = origin
      f.params[:to] = destination
    end
    parse(mq_response)
  end

  def self.conn
    Faraday.new(url: 'http://www.mapquestapi.com') do |f|
      f.params[:key] = ENV['GEO_KEY']
    end
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
