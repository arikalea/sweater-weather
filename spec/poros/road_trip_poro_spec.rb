require 'rails_helper'

RSpec.describe 'Roadtrip poro' do
  describe 'happy path' do
    it 'can create poro' do
      road_trip_data = { route: {
                            formattedTime: '14:06:04',
                            time: 4456
                          },
                         info: {
                            messages: []
                                }}
      origin = "Provo"
      destination = "Ogden"
      forecast_data = { hourly: [{:temp=>47.88,
                                  :weather=>[{:id=>803,
                                              :main=>"Clouds",            :description=>"broken clouds"}]},
                                  {:temp=>47.88,
                                   :weather=>[{:id=>803,
                                               :main=>"Clouds",
                                               :description=>"partly cloudy with a chance of meatballs"}]}
                                  ]}
      road_trip_poro = RoadTrip.new(road_trip_data, origin, destination, forecast_data)
      
      expect(road_trip_poro).to be_a(RoadTrip)
      expect(road_trip_poro.end_city).to be_a(String)
      expect(road_trip_poro.end_city).to eq(destination)
      expect(road_trip_poro.start_city).to be_a(String)
      expect(road_trip_poro.start_city).to eq(origin)
      expect(road_trip_poro.travel_time).to be_a(String)
      expect(road_trip_poro.weather_at_eta).to be_a(Hash)
      expect(road_trip_poro.weather_at_eta.keys).to eq([:temperature, :conditions])
      expect(road_trip_poro.weather_at_eta[:temperature]).to be_a(Float)
      expect(road_trip_poro.weather_at_eta[:conditions]).to be_a(String)
    end
  end
end
