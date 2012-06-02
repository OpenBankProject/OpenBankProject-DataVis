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
    
    #receivers = Array.new
    i = 0
    parsed_json.each do |result|
      i++
      receiver = Receiver.create(:ReceiverID => i, :Name => result["obp_transaction"]["other_account"]["holder"]["holder"], :alias => result["obp_transaction"]["other_account"]["holder"]["alias"], :BankAccountNumber => "", :OpenCorporateURL => "")
      receiver.save
      #receivers << receiver
    end
    #puts receivers.inspect
  end
end
