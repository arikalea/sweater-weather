class Image
  attr_reader :id,
              :location,
              :url,
              :credit

  def initialize(data, location)
    @id = nil
    @location = location
    @url = data[:url]
    @credit = { source: 'pexels.com',
                photographer: data[:photographer] }
  end
end
