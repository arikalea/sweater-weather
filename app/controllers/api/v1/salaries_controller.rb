class Api::V1::SalariesController < ApplicationController
  def show
    # search = params[:search]
    #
    # tele_conn = Faraday.new(url: 'https://api.teleport.org/api/')
    #
    # tele_response = tele_conn.get('/api/cities/') do |f|
    #   f.params['search'] = search
    #   f.params['limit'] = 1
    # end
    # tele_parse = JSON.parse(tele_response.body)['_embedded']['city:search-results'][0]['_links']['city:item']['href']
    #
    # response = Faraday.get(tele_parse)
    # parse = JSON.parse(response.body, symbolize_names: true)
    require "pry";binding.pry
  end
end
