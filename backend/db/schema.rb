# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20120603102052) do

  create_table "categories", :force => true do |t|
    t.string   "category_type"
    t.integer  "parent_category_id"
    t.string   "category_name"
    t.datetime "created_at",         :null => false
    t.datetime "updated_at",         :null => false
  end

  create_table "senders", :force => true do |t|
    t.string   "SenderID"
    t.string   "name"
    t.string   "alias"
    t.integer  "BankAccountNumber"
    t.string   "OpenCorporateURL"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "transaction_dates", :force => true do |t|
    t.integer  "day"
    t.integer  "month"
    t.integer  "year"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "transaction_partners", :force => true do |t|
    t.string   "account_holder"
    t.string   "bank_name"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "transactions", :force => true do |t|
    t.integer  "amount"
    t.string   "account_holder"
    t.datetime "created_at",             :null => false
    t.datetime "updated_at",             :null => false
    t.integer  "category_id"
    t.integer  "transaction_date_id"
    t.integer  "transaction_partner_id"
    t.string   "transaction_uuid"
  end

end
