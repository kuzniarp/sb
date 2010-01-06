# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20091014180650) do

  create_table "albums", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.string  "url_name"
    t.integer "gallery_id"
    t.integer "album_order"
  end

  create_table "meta_tags", :force => true do |t|
    t.string  "title"
    t.string  "description"
    t.string  "keywords"
    t.integer "content_id"
    t.string  "content_type"
  end

  create_table "photos", :force => true do |t|
    t.string  "name"
    t.text    "description"
    t.string  "url_name"
    t.string  "file"
    t.integer "album_id"
  end

  create_table "subpages", :force => true do |t|
    t.string   "name"
    t.string   "header"
    t.text     "description"
    t.string   "url_name"
    t.string   "type"
    t.integer  "page_order"
    t.integer  "parent_id"
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
  end

end
