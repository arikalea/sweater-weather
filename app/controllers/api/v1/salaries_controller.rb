class Api::V1::SalariesController < ApplicationController
  def show
    destination = params['destination']

    tele_conn = Faraday.new(url: 'https://api.teleport.org/api')
    #
    tele_response = tele_conn.get("/urban_areas/{ua_id}/salaries/") do |f|
      f.params['slug'] = destination
    end

    tele_parse = JSON.parse(tele_response.body, symbolize_names: true)
    require "pry";binding.pry
    #
    # response = Faraday.get(tele_parse)
    # parse = JSON.parse(response.body, symbolize_names: true)
  end
end
