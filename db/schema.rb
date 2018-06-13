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

ActiveRecord::Schema.define(version: 2018_06_12_151506) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_admins_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_admins_on_resource_type_and_resource_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource_type_and_resource_id"
  end

  create_table "things", force: :cascade do |t|
    t.string "name", null: false
    t.text "description"
    t.boolean "visible", default: false, null: false
    t.bigint "user_id"
    t.bigint "borrower_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["borrower_id"], name: "index_things_on_borrower_id"
    t.index ["user_id"], name: "index_things_on_user_id"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "name"
    t.text "notes"
    t.bigint "lender_id"
    t.bigint "borrower_id"
    t.bigint "thing_id"
    t.datetime "borrowed_at"
    t.datetime "returned_at"
    t.datetime "return_planned_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["borrower_id"], name: "index_transactions_on_borrower_id"
    t.index ["lender_id"], name: "index_transactions_on_lender_id"
    t.index ["thing_id"], name: "index_transactions_on_thing_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "nickname"
    t.integer "karma", default: 0, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_admins", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "admin_id"
    t.index ["admin_id"], name: "index_users_admins_on_admin_id"
    t.index ["user_id", "admin_id"], name: "index_users_admins_on_user_id_and_admin_id"
    t.index ["user_id"], name: "index_users_admins_on_user_id"
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "things", "users"
  add_foreign_key "transactions", "things"

  create_view "expired_loans",  sql_definition: <<-SQL
      SELECT transactions.id AS transaction_id,
      transactions.lender_id,
      lenders.email AS lender_email,
      lenders.first_name AS lender_first_name,
      transactions.borrower_id,
      borrowers.first_name AS borrower_first_name,
      borrowers.email AS borrower_email,
      transactions.return_planned_at,
      date_part('day'::text, age((('now'::text)::date)::timestamp without time zone, transactions.return_planned_at)) AS after_return_date
     FROM (((transactions
       JOIN things ON ((transactions.thing_id = things.id)))
       JOIN users lenders ON ((transactions.lender_id = lenders.id)))
       JOIN users borrowers ON ((transactions.borrower_id = borrowers.id)))
    WHERE ((transactions.returned_at IS NULL) AND (transactions.return_planned_at <= now()));
  SQL

end
