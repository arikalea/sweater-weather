class SalariesFacade
  attr_reader :destination,
              :forecast,
              :salaries

  def initialize(destination)
    @destination = destination
    @forecast = current_forecast
    @salaries = SalariesService.get_salary_info(@destination)
  end

  def current_forecast
    forecast = ForecastFacade.get_forecast(@destination)
    { summary: forecast.current.conditions,
      temperature: "#{forecast.current.temperature} F" }
  end
end
