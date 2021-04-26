class TeleportFacade
  def get_salary_info(ua_id)
    salary_data = TeleportService.get_salary_info(ua_id)
  end
end
