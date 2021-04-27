class SalariesFacade
  attr_reader :destination,
              :forecast,
              :salaries

  def initialize(destination)
    @destination = destination
    # @forecast =
    # @salaries =
  end

  def self.get_salary_info(destination)
    salary_data = SalariesService.get_salary_info(destination)
  end
end
