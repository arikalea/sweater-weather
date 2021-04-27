require 'rails_helper'

RSpec.describe 'Salaries Facade' do
  it 'can be created with all attributes' do
    salaries_facade = SalariesFacade.new('denver')
    # require "pry";binding.pry
    expect(salaries_facade).to be_a(SalariesFacade)
    expect(salaries_facade.destination).to eq('denver')
    expect(salaries_facade.forecast).to be_a(Hash)
    expect(salaries_facade.forecast.keys).to eq([:summary, :temperature])
    # expect(salaries_facade.salaries).to eq()
  end
end