class SalariesFacade
  def self.get_salary_info(ua_id)
    salary_data = SalariesService.get_salary_info(ua_id)
  end
end
