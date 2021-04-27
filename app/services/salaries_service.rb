class SalariesService
  def self.get_salary_info(destination)
    # tele_conn = Faraday.new(url: 'https://api.teleport.org/api/')
    # tele_parse = JSON.parse(tele_response.body, symbolize_names: true)
    tele_response = conn.get("urban_areas/slug:#{destination}/salaries/")
    parse(tele_response)
  end

  private

  def self.conn
    Faraday.new(url: 'https://api.teleport.org/api/')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
