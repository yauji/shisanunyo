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

ActiveRecord::Schema.define(:version => 20131104034114) do

  create_table "account_trans", :force => true do |t|
    t.float    "income"
    t.float    "expenditure"
    t.text     "memo"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
    t.date     "date"
    t.integer  "account_id",  :default => 1
  end

  add_index "account_trans", ["account_id"], :name => "index_account_trans_on_account_id"

  create_table "accounts", :force => true do |t|
    t.string   "currency"
    t.float    "balance"
    t.float    "exchangeRate"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.text     "memo"
  end

  create_table "base_issues", :force => true do |t|
    t.string   "baseCurrency"
    t.float    "principalForeign"
    t.string   "status"
    t.string   "name"
    t.integer  "valueJPY"
    t.float    "valueForeign"
    t.float    "exchangeRate"
    t.float    "interestRate"
    t.integer  "duration"
    t.integer  "noItem"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "type"
    t.integer  "principalJPY"
    t.date     "date"
    t.date     "endDate"
    t.text     "memo"
    t.string   "principalCurrency"
  end

  create_table "trade_logs", :force => true do |t|
    t.string   "type"
    t.integer  "basicPrice"
    t.integer  "noItem"
    t.integer  "buyValueJPY"
    t.float    "buyValueForeign"
    t.integer  "sellValueJPY"
    t.float    "sellValueForeign"
    t.integer  "dividendValueJPY"
    t.float    "dividendValueForeign"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
    t.date     "date"
    t.text     "memo"
    t.integer  "base_issue_id"
  end

  add_index "trade_logs", ["base_issue_id"], :name => "index_trade_logs_on_base_issue_id"

end
