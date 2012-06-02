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

  def index2
	data = Array.new

	expenses = Transaction.find_by_sql("SELECT sum(amount) as expenses FROM transactions WHERE amount < 0").first.expenses
	data << _get_data_item("Expenses", expenses)

	income = Transaction.find_by_sql("SELECT sum(amount) as income FROM transactions WHERE amount > 0").first.income
	data << _get_data_item("Income", income)

  categories = Category.find(:all)

  categories.each do |category|
    if category.parent then
      sum = 0
      category.transactions.each do |transaction|
        sum += transaction.amount
      end

      data << _get_data_item(category.category_name, sum, category.parent.category_name)
    end
  end

	respond_to do |format|
	  format.json { render :json => data }
	end
end

  protected

  def _get_data_item(name, volume, parent = nil)
  	volume ||= 0
  	data_item = Hash.new
  	data_item[:name]   = name
  	data_item[:volume] = volume.to_i.abs
  	data_item[:parent] = parent
  	data_item[:heat]   = 0
  	data_item
  end

end
