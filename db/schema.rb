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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20160110125523) do

  create_table "admins", force: :cascade do |t|
    t.string   "login"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "password_digest"
    t.string   "remember_digest"
  end

  create_table "functions", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal  "factor"
  end

  create_table "functions_products", id: false, force: :cascade do |t|
    t.integer "product_id",  null: false
    t.integer "function_id", null: false
  end

  add_index "functions_products", ["function_id", "product_id"], name: "index_functions_products_on_function_id_and_product_id"
  add_index "functions_products", ["product_id", "function_id"], name: "index_functions_products_on_product_id_and_function_id"

  create_table "operations", force: :cascade do |t|
    t.string   "name"
    t.decimal  "rate"
    t.decimal  "duration"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "task_id"
  end

  add_index "operations", ["task_id"], name: "index_operations_on_task_id"

  create_table "operations_users", id: false, force: :cascade do |t|
    t.integer "user_id",      null: false
    t.integer "operation_id", null: false
  end

  add_index "operations_users", ["operation_id", "user_id"], name: "index_operations_users_on_operation_id_and_user_id"
  add_index "operations_users", ["user_id", "operation_id"], name: "index_operations_users_on_user_id_and_operation_id"

  create_table "products", force: :cascade do |t|
    t.string   "name"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal  "price"
  end

  add_index "products", ["user_id"], name: "index_products_on_user_id"

  create_table "tasks", force: :cascade do |t|
    t.string   "name"
    t.datetime "start"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal  "average"
    t.decimal  "rate"
  end

end
