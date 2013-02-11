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

ActiveRecord::Schema.define(:version => 20130211133540) do

  create_table "admins", :force => true do |t|
    t.string   "email",           :null => false
    t.string   "password_digest", :null => false
    t.string   "name"
    t.string   "role"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.string   "remember_token"
  end

  add_index "admins", ["remember_token"], :name => "index_admins_on_remember_token"

  create_table "posts", :force => true do |t|
    t.integer  "user_id",                          :null => false
    t.string   "title",                            :null => false
    t.string   "name",                             :null => false
    t.integer  "age",                              :null => false
    t.string   "former_job",                       :null => false
    t.integer  "total_tally",   :default => 0
    t.integer  "total_good",    :default => 0
    t.integer  "total_bad",     :default => 0
    t.integer  "reported_spam", :default => 0
    t.string   "permalink"
    t.boolean  "verified",      :default => false
    t.datetime "created_at",                       :null => false
    t.datetime "updated_at",                       :null => false
  end

  create_table "posts_votes", :force => true do |t|
    t.string   "unique_identifier"
    t.boolean  "vote_good"
    t.boolean  "vote_bad"
    t.boolean  "set_spam"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.integer  "age"
    t.string   "likes"
    t.text     "others"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.string   "email"
  end

end
