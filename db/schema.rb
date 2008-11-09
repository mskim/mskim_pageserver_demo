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

ActiveRecord::Schema.define(:version => 20081025052047) do

  create_table "ads", :force => true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "company"
    t.string   "business_item"
    t.string   "copy1"
    t.string   "copy2"
    t.string   "phone2"
    t.string   "fax"
    t.string   "www"
    t.string   "hp"
    t.string   "kind"
    t.string   "size"
    t.string   "template"
    t.string   "geo_code"
    t.string   "country"
    t.string   "city"
    t.string   "area"
    t.string   "category1"
    t.string   "category2"
    t.string   "category3"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "bookings", :force => true do |t|
    t.integer  "ad_id"
    t.string   "media"
    t.date     "posting_date"
    t.string   "page"
    t.string   "position"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
