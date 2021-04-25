require 'rails_helper'

RSpec.describe 'Background Facade' do
  it '.get_background' do
    VCR.use_cassette('stevens_point_image') do
      background = BackgroundFacade.get_background('Stevens Point')

      expect(background).to be_an(Image)
    end
  end
end
