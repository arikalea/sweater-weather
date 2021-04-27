require 'rails_helper'

RSpec.describe SalariesFacade do
  it 'can be created with all attributes' do
    salaries_facade = SalariesFacade.new('denver')

    expect(salaries_facade).to be_a(SalariesFacade)
    expect(salaries_facade.destination).to eq('denver')
    expect(salaries_facade.forecast).to be_a(Hash)
    expect(salaries_facade.forecast.keys).to eq([:summary, :temperature])
    expect(salaries_facade.salaries).to be_an(Array)
    expect(salaries_facade.salaries.first).to be_a(Job)
  end

  it 'can find current forecast' do
    salaries_facade = SalariesFacade.new('denver')

    current_forecast = salaries_facade.current_forecast

    expect(current_forecast).to be_a(Hash)
    expect(current_forecast.keys).to eq([:summary, :temperature])
  end
end
