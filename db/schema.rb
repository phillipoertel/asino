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

ActiveRecord::Schema.define(:version => 20130129225656) do

  create_table "accounts", :force => true do |t|
    t.string   "title"
    t.string   "feed"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "importer",   :default => "Saldomat"
  end

  create_table "backups", :force => true do |t|
    t.string   "file_name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.boolean  "transfer",    :default => false, :null => false
  end

  add_index "categories", ["category_id"], :name => "index_categories_on_category_id"

  create_table "items", :force => true do |t|
    t.integer  "account_id"
    t.decimal  "amount",      :precision => 9, :scale => 2
    t.string   "payee"
    t.string   "description"
    t.string   "uid"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "category_id"
    t.boolean  "transfer",                                  :default => false, :null => false
    t.boolean  "fix",                                       :default => false, :null => false
    t.string   "note"
  end

  add_index "items", ["account_id"], :name => "index_items_on_account_id"
  add_index "items", ["category_id"], :name => "index_items_on_category_id"

  create_table "monthreports", :force => true do |t|
    t.date     "date"
    t.decimal  "expenses",   :precision => 9, :scale => 2, :default => 0.0, :null => false
    t.decimal  "income",     :precision => 9, :scale => 2, :default => 0.0, :null => false
    t.integer  "account_id"
    t.decimal  "saldo",      :precision => 9, :scale => 2, :default => 0.0, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "monthreports", ["account_id"], :name => "index_monthreports_on_account_id"

  create_table "rules", :force => true do |t|
    t.integer  "ruleset_id"
    t.string   "affected_attribute"
    t.string   "matching_string"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "matchtype"
  end

  add_index "rules", ["ruleset_id"], :name => "index_rules_on_ruleset_id"

  create_table "rulesets", :force => true do |t|
    t.string   "name"
    t.integer  "account_id"
    t.boolean  "active",           :default => true, :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "action"
    t.string   "action_parameter"
  end

  add_index "rulesets", ["account_id"], :name => "index_rulesets_on_account_id"

  create_table "users", :force => true do |t|
    t.string   "email",                               :default => "", :null => false
    t.string   "encrypted_password",   :limit => 128, :default => "", :null => false
    t.string   "reset_password_token"
    t.string   "remember_token"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                       :default => 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "username"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
