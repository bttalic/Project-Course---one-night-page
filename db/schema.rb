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

ActiveRecord::Schema.define(:version => 20130522084745) do

  create_table "coursefiles", :force => true do |t|
    t.integer  "course_id"
    t.string   "description"
    t.string   "name"
    t.datetime "created_at",        :null => false
    t.datetime "updated_at",        :null => false
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  create_table "courses", :force => true do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "description"
    t.string   "coursecode"
    t.string   "code"
    t.boolean  "lock"
  end

  add_index "courses", ["user_id", "created_at"], :name => "index_courses_on_user_id_and_created_at"

  create_table "notifications", :force => true do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "course_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "notifications", ["user_id", "created_at", "course_id"], :name => "index_notifications_on_user_id_and_created_at_and_course_id"

  create_table "relationships", :force => true do |t|
    t.integer  "listener_id"
    t.integer  "listened_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "relationships", ["listened_id"], :name => "index_relationships_on_listened_id"
  add_index "relationships", ["listener_id", "listened_id"], :name => "index_relationships_on_listener_id_and_listened_id", :unique => true
  add_index "relationships", ["listener_id"], :name => "index_relationships_on_listener_id"

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "password_digest"
    t.string   "remember_token"
    t.boolean  "admin",               :default => false
    t.boolean  "professor",           :default => false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "officehours"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["remember_token"], :name => "index_users_on_remember_token"

end
