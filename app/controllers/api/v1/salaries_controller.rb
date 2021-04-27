class Api::V1::SalariesController < ApplicationController
  def show
    ua_id = params['destination']

    # tele_conn = Faraday.new(url: 'https://api.teleport.org/api/')
    #
    # tele_response = tele_conn.get("urban_areas/slug:#{ua_id}/salaries/")
    #
    # tele_parse = JSON.parse(tele_response.body, symbolize_names: true)
    #
    tele_info = SalariesFacade.get_salary_info(ua_id)
    jobs = []
    tele_info[:salaries].map do |job|
      jobs << job if job[:job][:title] == "Data Analyst"
      jobs << job if job[:job][:title] == "Data Scientist"
      jobs << job if job[:job][:title] == "Mobile Developer"
      jobs << job if job[:job][:title] == "QA Engineer"
      jobs << job if job[:job][:title] == "Software Engineer"
      jobs << job if job[:job][:title] == "Systems Administrator"
      jobs << job if job[:job][:title] == "Web Developer"
    end

    forecast_data = ForecastFacade.get_forecast(ua_id)
    forecast_summary = forecast_data.current.conditions
    forecast_temp = forecast_data.current.temperature

    response = {
      "data": {
        "id": "null",
        "type": "salaries",
        "attributes": {
          "destination": ua_id,
          "forecast": {
            "summary": forecast_summary,
            "temperature": "#{forecast_temp} F"
          },
          "salaries": [
            {
              "title": jobs.first[:job][:title],
              "min": jobs.first[:salary_percentiles][:percentile_25].round(2),
              "max": jobs.first[:salary_percentiles][:percentile_75].round(2),
            }
          ]
        }
      }
    }
    render json: response
  end
end
