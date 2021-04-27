class SalariesService
  def self.get_salary_info(destination)
    tele_response = conn.get("urban_areas/slug:#{destination}/salaries/")
    tele_json = parse(tele_response)
    all_jobs = tele_json[:salaries].map do |data|
      Job.new(data)
    end
    find_job_titles(all_jobs)
  end

  def self.find_job_titles(all_jobs)
    job_titles = ["Data Analyst", "Data Scientist", "Mobile Developer", "QA Engineer", "Software Engineer", "Systems Administrator", "Web Developer"]

    all_jobs.find_all do |job|
      job if job_titles.include?(job.title)
    end
  end

  def self.conn
    Faraday.new(url: 'https://api.teleport.org/api/')
  end

  def self.parse(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
