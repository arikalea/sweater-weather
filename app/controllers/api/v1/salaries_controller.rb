class Api::V1::SalariesController < ApplicationController
  def show
    destination = params['destination']
    salary_info = SalariesFacade.new(destination)
    render json: SalariesSerializer.new(salary_info)
  end
end
