# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2022_05_16_200409) do
  create_table "categories", force: :cascade do |t|
    t.string "tipo_categoria"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_productos", id: false, force: :cascade do |t|
    t.integer "category_id", null: false
    t.integer "producto_id", null: false
    t.index ["category_id", "producto_id"], name: "index_categories_productos_on_category_id_and_producto_id"
    t.index ["producto_id", "category_id"], name: "index_categories_productos_on_producto_id_and_category_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "nombre_cli"
    t.string "nombre2_cli"
    t.string "apellido_cli"
    t.string "apellido2_cli"
    t.integer "tel_cli"
    t.string "correo_cli"
    t.integer "cedula"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "detalles", force: :cascade do |t|
    t.integer "factura_id", null: false
    t.integer "producto_id", null: false
    t.integer "cantidad"
    t.decimal "valor", precision: 3, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["factura_id"], name: "index_detalles_on_factura_id"
    t.index ["producto_id"], name: "index_detalles_on_producto_id"
  end

  create_table "facturas", force: :cascade do |t|
    t.integer "client_id", null: false
    t.decimal "total", precision: 3, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_facturas_on_client_id"
  end

  create_table "productos", force: :cascade do |t|
    t.string "nombre_pro"
    t.string "referencia_pro"
    t.decimal "precio_pro", precision: 3, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "resource_type"
    t.integer "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id"
    t.index ["name"], name: "index_roles_on_name"
    t.index ["resource_type", "resource_id"], name: "index_roles_on_resource"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "primernombre"
    t.string "segundonombre"
    t.string "primerapellido"
    t.string "segundoapellido"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
    t.index ["role_id"], name: "index_users_roles_on_role_id"
    t.index ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id"
    t.index ["user_id"], name: "index_users_roles_on_user_id"
  end

  add_foreign_key "detalles", "facturas"
  add_foreign_key "detalles", "productos"
  add_foreign_key "facturas", "clients"
end
