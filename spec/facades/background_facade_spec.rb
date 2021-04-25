require 'rails_helper'

RSpec.describe 'Background Facade' do
  it '.get_background' do
    VCR.use_cassette('stevens_point_image') do
      background = BackgroundFacade.get_background('Stevens Point')

      expect(background).to be_an(Image)
      expect(background.id).to be_nil
      expect(background.location).to be_a(String)
      expect(background.url).to be_a(String)
      expect(background.credit).to be_a(Hash)
    end
  end
end
