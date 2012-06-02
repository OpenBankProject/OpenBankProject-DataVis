require 'json/add/rails'
require 'open-uri'
require 'yaml'
require 'date'
require 'Obp_transactions'
YAML::ENGINE.yamler = 'syck'

class ApireaderController < ApplicationController
  def index
    file_handle = open("https://demo.openbankproject.com/api/accounts/tesobe/anonymous")
    transactions = ActiveSupport::JSON.decode(file_handle)
    #parsed_json["results"].each do |longUrl, convertedUrl|
    #print parsed_json[0]["obp_transaction"]["this_account"]["holder"]["holder"].inspect
    
    tr = nil
    
    transactions.each do |transaction|
      tp=TransactionPartner.new(:account_holder =>transaction["obp_transaction"]["other_account"]["holder"]["holder"],:bank_name => "Bank")
      tp.save
    
    
      # 2012-03-05T00:00:00.001Z
      transaction_date = transaction["obp_transaction"]["details"]["completed"]
      d = Date.strptime(transaction_date, '%Y-%m-%d')
    
    
    
      td = TransactionDate.new(:day => d.mday, :month => d.mon, :year => d.year)
      td.save
    
    
      #details.date_posted = transactions["obp_transaction"]["details"]["posted"]
    
      #details.value.currency = transactions["obp_transaction"]["details"]["value"]["currency"]
    
      amount = transaction["obp_transaction"]["details"]["value"]["amount"]
      cat = Category.new(:category_name => get_category(tp.account_holder), :category_type => get_category_type(amount))
      cat.save
      holder = transaction["obp_transaction"]["this_account"]["holder"]["holder"]
      
      tr = Transaction.new(:account_holder => holder, :amount => amount)
      #tr.Category = cat
      #tr.TransactionDate = td
      #tr.TransactionPartner = tp
      tr.save
      
      
    
    
    
    #obp_comments = transactions["obp_transaction"]["value"]
    
    #puts parsed_json.count
    end
    c = Category.first
    puts "Xxxxxxxxxxx" + c.transactions.inspect
    puts "rgerhtzrjrzhgergjrekjherjhgjkerh" + tr.inspect
    
    
  end
  def read_categorization_files
    root_dir = Rails.root.to_s + '/Categorisation/*'
    cat_files = Dir.glob(root_dir)
    @cats = Hash.new
    cat_files.each do |file|
      cat = file.split("/").last
      File.open(file, "r").each_line do |line|
        holder = line.delete("\n")
        @cats[holder] = cat unless holder.empty?
      end
    end
  end
  
  def get_category(account_holder)
    root_dir = Rails.root.to_s + '/Categorisation/*'
    cat_files = Dir.glob(root_dir)
    @cats = Hash.new
    cat_files.each do |file|
      cat = file.split("/").last
      File.open(file, "r").each_line do |line|
        holder = line.delete("\n")
        @cats[holder] = cat unless holder.empty?
      end
    end
    
    
    puts account_holder+"blaaaaahhgggggggggggggkkgkgkgkkgkkkk"
    puts @cats.inspect
    if @cats[account_holder].nil?
      return "others"
    else
      return @cats[account_holder]
    end
  end
  
  def get_category_type(amount)
    puts "blubbbbber" + amount
    if amount.to_i > 0
      return "income"
    else
      return "expense"
    end
  end
end