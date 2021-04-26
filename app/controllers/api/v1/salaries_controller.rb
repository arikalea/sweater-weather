class Api::V1::SalariesController < ApplicationController
  def show
    ua_id = params['destination']

    tele_conn = Faraday.new(url: 'https://api.teleport.org/api/') do |f|
    end

    tele_response = tele_conn.get("urban_areas/slug:#{ua_id}/salaries/") do |f|
      # f.params['slug'] = ua_id
    end

    tele_parse = JSON.parse(tele_response.body, symbolize_names: true)

    jobs = []
    tele_parse[:salaries].map do |job|
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
    require "pry";binding.pry
  end
end
