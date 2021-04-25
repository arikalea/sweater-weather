class BackgroundService
  def self.get_img_by_location(location)
    background_response = conn.get('v1/search') do |f|
      f.params[:query] = "#{location}, landscape"
      f.params[:orientation] = 'landscape'
      f.params[:per_page] = 1
    end
    parse(background_response)[:photos][0]
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.pexels.com/') do |f|
      f.headers['Authorization'] = ENV['PEXELS_KEY']
    end
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
