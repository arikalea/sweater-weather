require 'rails_helper'

RSpec.describe 'Background Service' do
  it 'can retrieve image based on location' do
    VCR.use_cassette('dallas_image') do
      image_results = BackgroundService.get_img_by_location('Dallas')

      expect(image_results).to be_a(Hash)
      expect(image_results).to have_key(:url)
      expect(image_results[:url]).to be_a(String)
      expect(image_results).to have_key(:photographer)
      expect(image_results[:photographer]).to be_a(String)
    end
  end
end
