class GeoService
  def self.location_data(location)
    geo_response = conn.get('/geocoding/v1/address') do |f|
      f.params[:location] = location
    end
    # require "pry";binding.pry
    parse(geo_response)
    # lat_long = geo_json[:results][0][:locations][0][:latLng]
    # lat = lat_long[:lat]
    # long = lat_long[:lng]
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
