require 'json/add/rails'
require 'open-uri'
require 'yaml'
YAML::ENGINE.yamler = 'syck'

class ApireaderController < ApplicationController
  def index
    file_handle = open("https://demo.openbankproject.com/api/accounts/tesobe/anonymous")
    parsed_json = ActiveSupport::JSON.decode(file_handle)
    #parsed_json["results"].each do |longUrl, convertedUrl|
    #print parsed_json[0]["obp_transaction"]["this_account"]["holder"]["holder"].inspect
    
    parsed_json.each do |result|
      output = "#{result["obp_transaction"]["other_account"]["holder"]["holder"]}"
      puts output
    end
    puts parsed_json.count
  end
end