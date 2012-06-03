require 'json/add/rails'
require 'open-uri'
require 'yaml'
require 'date'
require 'Obp_transactions'
YAML::ENGINE.yamler = 'syck'

class ApireaderController < ApplicationController

  def update
    Transaction.delete_all
    TransactionPartner.delete_all
    TransactionDate.delete_all
    _update_categories

    file_handle = open("https://demo.openbankproject.com/api/accounts/tesobe/anonymous")
    transactions = ActiveSupport::JSON.decode(file_handle)

    transactions.each do |transaction|
      partner = transaction["obp_transaction"]["other_account"]["holder"]["holder"]
      tp = TransactionPartner.find_by_account_holder partner

      if tp.nil?
        tp = TransactionPartner.new :account_holder => partner
        tp.save!
      end

      transaction_date = transaction["obp_transaction"]["details"]["completed"]
      date = Date.strptime transaction_date, '%Y-%m-%d'
      td = TransactionDate.new :day => date.mday,
                               :month => date.mon,
                               :year => date.year
      td.save!

      amount = transaction["obp_transaction"]["details"]["value"]["amount"].to_i
      holder = transaction["obp_transaction"]["this_account"]["holder"]["holder"]
      tr = Transaction.new :account_holder => holder,
                           :amount => amount.to_i.abs
      tr.transaction_uuid       = transaction["obp_transaction"]["obp_transaction_uuid"]
      # we need the balance from the api!
      #tr.balance                = transaction["obp_transaction"]["details"]["details"]
      tr.category_id            = _get_category_id(partner, amount)
      tr.transaction_date_id    = td.id
      tr.transaction_partner_id = tp.id
      tr.save
    end
  end

  def get_categories
    data = _get_category_data
    respond_to do |format|
      format.json { render :json => data }
    end
  end
  
  def get_payees
    cat = Category.find_by_category_name(params[:category])
    data = Array.new
    cat.transactions.group_by(&:transaction_partner_id).each do |holder, transactions|
      data_item = Hash.new
      data_item[:name] = TransactionPartner.find_by_id(holder).account_holder
      data_item[:volume] = transactions.collect{|t| t.amount.abs}.inject(:+)
      data << data_item
    end
    render :json => data
  end

  def past10days
    data = Array.new
    data.push Hash[:name => '05/01', :income => 2000, :expenses => 1000, :balance => 12000]
    data.push Hash[:name => '05/02', :income => 1000, :expenses => 300, :balance => 11000]
    data.push Hash[:name => '05/03', :income => 4000, :expenses => 2000, :balance => 12000]
    data.push Hash[:name => '05/04', :income => 2000, :expenses => 100, :balance => 13000]
    data.push Hash[:name => '05/05', :income => 1000, :expenses => 50, :balance => 22000]
    data.push Hash[:name => '05/06', :income => 5000, :expenses => 100, :balance => 210000]
    data.push Hash[:name => '05/07', :income => 3000, :expenses => 2000, :balance => 250000]
    data.push Hash[:name => '05/08', :income => 5000, :expenses => 1000, :balance => 270000]
    data.push Hash[:name => '05/09', :income => 7000, :expenses => 4000, :balance => 280000]
    data.push Hash[:name => '05/10', :income => 8000, :expenses => 100, :balance => 290000]
    render :json => data
  end

  def average_past_year
    data = Array.new
    data.push Hash[:expenses => 50]
    render :json => data
  end

  def test
    # categories = _get_categories - this works
    # _update_categories # - this works
    # puts get_holder_to_category_id_map #- this works
  end
  
  def get_monthly_balance
    #TransactionDate.find_by_sql(:day, :month, :year, "SUM() as sum_images_count").group(:month, :province, :country).order("sum_images_count DESC")
    #.find(:group => [:year, :month], :order => [:year, :month]) do |transaction|
    #  puts transaction.inspect
    #end
    data = Array.new
    
    data.push Hash[:name => "2012/01", :income => 6000, :expenses => 4000, :balance => 2000]
    data.push Hash[:name => "2012/02", :income => 4000, :expenses => 4000, :balance => 2000]
    data.push Hash[:name => "2012/01", :income => 2000, :expenses => 2000, :balance => 2000]
    data.push Hash[:name => "2012/03", :income => 7000, :expenses => 6000, :balance => 3000]
    data.push Hash[:name => "2012/04", :income => 1000, :expenses => 2000, :balance => 2000]
    data.push Hash[:name => "2012/05", :income => 3000, :expenses => 1000, :balance => 4000]
    data.push Hash[:name => "2012/06", :income => 6000, :expenses => 4000, :balance => 6000]
    
    render :json => data
  end
  

  def _get_category_id(account_holder, amount)
    @holder_to_category_id_map ||= get_holder_to_category_id_map

    puts account_holder
    if @holder_to_category_id_map[account_holder].nil?
      if amount < 0
        return Category.find_by_category_name("Others").id
      else
        return Category.find_by_category_name("Sales").id
      end
    else
      return @holder_to_category_id_map[account_holder]
    end
  end

  def get_holder_to_category_id_map
    root_dir = Rails.root.to_s + '/Categorisation/*'
    parent_categories = Dir.glob(root_dir)
    cateory_map = Hash.new
    category_data = get_categories_mapped_by_name

    # Expense and Income folder
    parent_categories.each do |directory|
      # All files (Categories inside Income and Expense)
      files = Dir.glob(directory + '/*')
      puts directory
      files.each do |file|
        # Name of the Category files
        puts file
        category = file.split("/").last
        # Content (Holders) of the Category
        File.open(file, "r").each_line do |line|
          holder = line.delete("\n")
          cateory_map[holder] = category_data[category].id unless holder.empty?
        end
      end
    end
    cateory_map
  end

  def get_categories_mapped_by_name
    categories = Category.all
    category_data = Hash.new
    categories.each do |category|
      category_data[category.category_name] = category
    end
    category_data
  end

  protected

  def _update_categories
    categories = _get_categories
    Category.delete_all

    categories.each do |parent, sub_categories|
      parent_category = Category.new :category_name => parent
      parent_category.save!

      sub_categories.each do |category|
        sub_category = Category.new :category_name => category,
                                    :parent_category_id => parent_category.id
        sub_category.save!
      end

      if parent == "Income"
        other_category_name = "Sales"
      elsif parent == "Expense"
        other_category_name = "Others"
      end

      other_category = Category.new :category_name => other_category_name,
                                    :parent_category_id => parent_category.id
      other_category.save!
    end
  end

  def _get_category_data
    data = Array.new
    exp_cat = Category.find_by_category_name("Expense")
    exp_sub_cat = Category.find_all_by_parent_category_id(exp_cat.id)
    expenses_sum = 0
    exp_sub_cat.each do |category|
      category.transactions.each do |transaction|
        expenses_sum += transaction.amount
      end
    end
    data << _get_data_item("Expenses",  expenses_sum)

    inc_cat = Category.find_by_category_name("Income")
    inc_sub_cat = Category.find_all_by_parent_category_id(inc_cat.id)
    income_sum = 0
    inc_sub_cat.each do |category|
      category.transactions.each do |transaction|
        income_sum += transaction.amount
      end
    end
    data << _get_data_item("Income", income_sum)

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

    data
  end

  def _get_data_item(name, volume, parent = nil)
  	volume ||= 0
  	data_item = Hash.new
  	data_item[:name]   = name
  	data_item[:volume] = volume.to_i.abs
  	data_item[:parent] = parent
  	data_item[:heat]   = 0
  	data_item
  end

  def _get_category_type(amount)
    if amount.to_i > 0
      return "income"
    else
      return "expense"
    end
  end

def _read_categorization_files
    root_dir = _get_category_files_dir
    cat_files = Dir.glob(root_dir)
    cats = Hash.new

    cat_files.each do |file|
      cat = file.split("/").last
      File.open(file, "r").each_line do |line|
        holder = line.delete("\n")
        cats[holder] = cat unless holder.empty?
      end
    end
  end

  def _get_categories
    root_dir   = _get_category_files_dir
    cat_files  = Dir.glob(root_dir)
    categories = Hash.new

    cat_files.each do |file|
      category_name = file.split("/").last
      if File.directory?(file)
        sub_files = Dir.glob(file + "/*")
        sub_categories = Array.new
        sub_files.each do |sub_file|
          sub_categories.push sub_file.split("/").last
        end
        categories[category_name] = sub_categories
      else
        categories[category_name] = nil
      end
    end

    categories
  end

  protected
  def _get_category_files_dir
    root_dir = Rails.root.to_s + '/Categorisation/*'
  end

end
