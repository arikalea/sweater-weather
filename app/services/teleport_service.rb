class TeleportService
  def get_salary_info(ua_id)
    # tele_conn = Faraday.new(url: 'https://api.teleport.org/api/')

    tele_response = conn.get("urban_areas/slug:#{ua_id}/salaries/")

    # tele_parse = JSON.parse(tele_response.body, symbolize_names: true)
    parse(tele_response)
  end

  private

  def conn
    Faraday.new(url: 'https://api.teleport.org/api/')
  end

  def parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
