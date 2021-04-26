class Api::V1::SalariesController < ApplicationController
  def show
    ua_id = params['destination']

    tele_conn = Faraday.new(url: 'https://api.teleport.org/api/') do |f|
    end

    tele_response = tele_conn.get("urban_areas/slug:#{ua_id}/salaries/") do |f|
      # f.params['slug'] = ua_id
    end

    tele_parse = JSON.parse(tele_response.body, symbolize_names: true)
    require "pry";binding.pry

    
  end
end
