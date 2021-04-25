require 'rails_helper'

RSpec.describe 'Image poro' do
  describe 'happy path' do
    it 'can create poro' do
      attrs = { url: 'example.com',
                photographer: 'Sally' }

      location = 'Dallas'

      img_credit = { source: "pexels.com",
                     photographer: attrs[:photographer] }

      image_poro = Image.new(attrs, location)

      expect(image_poro).to be_a(Image)
      expect(image_poro.id).to eq(nil)
      expect(image_poro.location).to eq(location)
      expect(image_poro.url).to eq(attrs[:url])
      expect(image_poro.credit).to eq(img_credit)
    end
  end
end
