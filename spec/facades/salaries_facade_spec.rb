require 'rails_helper'

RSpec.describe 'Salaries Facade' do
  it 'can be created with all attributes' do
    salaries_facade = SalariesFacade.new('denver')

    expect(salaries_facade).to be_a(SalariesFacade)
    expect(salaries_facade.destination).to eq('denver')
    # expect(salaries_facade.forecast).to eq()
    # expect(salaries_facade.salaries).to eq()
  end
end
