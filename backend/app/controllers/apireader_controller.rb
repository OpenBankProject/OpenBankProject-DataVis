require 'json/add/rails'
require 'open-uri'
require 'yaml'
require 'date'
require 'Obp_transactions'
YAML::ENGINE.yamler = 'syck'

class ApireaderController < ApplicationController

  def update
    file_handle = open("https://demo.openbankproject.com/api/accounts/tesobe/anonymous")
    transactions = ActiveSupport::JSON.decode(file_handle)

    transactions.each do |transaction|
      tp = TransactionPartner.new :account_holder => transaction["obp_transaction"]["other_account"]["holder"]["holder"],
                                  :bank_name => "Bank"
      tp.save!

      transaction_date = transaction["obp_transaction"]["details"]["completed"]
      d = Date.strptime transaction_date, '%Y-%m-%d'
      td = TransactionDate.new :day => d.mday,
                               :month => d.mon,
                               :year => d.year
      td.save!

      amount = amount.to_i.abs
      holder = transaction["obp_transaction"]["this_account"]["holder"]["holder"]
      tr = Transaction.new :account_holder => holder,
                           :amount => amount

      tr.category_id = _get_category_id holder, amount
      tr.transaction_date_id = td.id
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

  def test
    # categories = _get_categories - this works
    _update_categories # - this works
  end

  def _get_category_id(account_holder, amount)
    holder_to_category_map ||= get_holder_to_category_map

    if @cats[account_holder].nil?
      return "others"
    else
      return @cats[account_holder]
    end
  end

  def get_holder_to_category_map
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
    cat_files
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
