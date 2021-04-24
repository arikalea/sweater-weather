require 'rails_helper'

RSpec.describe 'Forecast Facade' do
  # rename this test
  it 'can parse info from endpoint' do
    forecast = ForecastFacade.get_forecast('Denver, CO')

    expect(forecast).to be_a(CurrentForecast)
    # expect(forecast)
  end
end
