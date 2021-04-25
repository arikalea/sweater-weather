class BackgroundFacade
  def self.get_background(location)
    background_data = BackgroundService.get_img_by_location(location)
    Image.new(background_data, location)
  end
end
