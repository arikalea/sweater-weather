class Location
  attr_reader :city,
              :state,
              :country,
              :coordinates

  def initialize(data)
    @city = data[:adminArea5]
    @state = data[:adminArea3]
    @country = data[:adminArea1]
    @coordinates = data[:latLng]
  end
end
