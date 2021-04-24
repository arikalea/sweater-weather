class Location
  attr_reader :city,
              :state,
              :country,
              :coordinates

  def initialize(data)
    @city = data[:results][0][:locations][0][:adminArea5]
    @state = data[:results][0][:locations][0][:adminArea3]
    @country = data[:results][0][:locations][0][:adminArea1]
    @coordinates = data[:results][0][:locations][0][:latLng]
  end
end
