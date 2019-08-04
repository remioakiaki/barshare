class RestaurantsController < ApplicationController
  def index
    
    array = { keyid: ENV['GNAVI_API_KEY'],
                name: params[:name],
                freeword: params[:freeword1],
                offset_page:params[:page]
                }

    if Time.now > Time.new(2019,9,3) 
      apiurl = "https://api.gnavi.co.jp/api/announcement/20180903/?"
    else
      apiurl = "https://api.gnavi.co.jp/RestSearchAPI/v3/?"
    end



    require 'net/http'
    require 'uri'
    require 'json'
    require 'logger'
    require 'dotenv'
    require 'active_support'
    require 'active_support/core_ext'
    require 'kaminari'
    
    
    params = URI.encode_www_form(array)
  
    uri = URI.parse(apiurl + params )
    

    begin
      response = Net::HTTP.new(uri.host, uri.port).yield_self do |http|
        http.use_ssl = true
        http.open_timeout = 5
        http.read_timeout = 30
        http.get(uri.request_uri)
      end

      case response
      when Net::HTTPSuccess

        hash = JSON.parse(response.body, symbolize_names: true)
      
        @restaurants = hash[:rest]

        if hash[:total_hit_count] <= 1000
          limit_paginate = hash[:total_hit_count] 
        else
          limit_paginate = 1000
        end
        
        @restaurants = Kaminari.paginate_array(hash[:rest],total_count:limit_paginate)
                       .page(hash[:page_offset])
                       .per(hash[:hit_per_page])

        
      when Net::HTTPRedirection
        logger.warn("Redirection: code=#{response.code} message=#{response.message}")
      else
        logger.error("HTTP ERROR: code=#{response.code} message=#{response.message}")
      end
    rescue IOError => e
      logger.error(e.message)
    rescue TimeoutError => e
      logger.error(e.message)
    rescue JSON::ParserError => e
      logger.error(e.message)
    rescue StandardError => e
      logger.error(e.message)
    end
  end
end

