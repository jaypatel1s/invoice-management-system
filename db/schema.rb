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

ActiveRecord::Schema[7.1].define(version: 20_250_918_104_006) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'branch_stocks', force: :cascade do |t|
    t.bigint 'branch_id', null: false
    t.bigint 'product_id', null: false
    t.integer 'quantity', default: 0, null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'stock_id', null: false
    t.index %w[branch_id product_id], name: 'index_branch_stocks_on_branch_id_and_product_id', unique: true
    t.index ['branch_id'], name: 'index_branch_stocks_on_branch_id'
    t.index ['product_id'], name: 'index_branch_stocks_on_product_id'
    t.index ['stock_id'], name: 'index_branch_stocks_on_stock_id'
  end

  create_table 'branches', force: :cascade do |t|
    t.bigint 'company_id', null: false
    t.string 'name', null: false
    t.string 'code'
    t.string 'address'
    t.string 'phone'
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_branches_on_company_id'
  end

  create_table 'companies', force: :cascade do |t|
    t.string 'name'
    t.string 'address'
    t.string 'phone'
    t.string 'email'
    t.string 'tax_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'customers', force: :cascade do |t|
    t.bigint 'company_id', null: false
    t.bigint 'user_id', null: false
    t.string 'name', null: false
    t.string 'phone'
    t.string 'email'
    t.string 'address'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_customers_on_company_id'
    t.index ['user_id'], name: 'index_customers_on_user_id'
  end

  create_table 'invoices', force: :cascade do |t|
    t.string 'invoice_number'
    t.date 'date'
    t.date 'due_date'
    t.string 'status'
    t.text 'note'
    t.bigint 'company_id', null: false
    t.bigint 'customer_id', null: false
    t.bigint 'user_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_invoices_on_company_id'
    t.index ['customer_id'], name: 'index_invoices_on_customer_id'
    t.index ['user_id'], name: 'index_invoices_on_user_id'
  end

  create_table 'ledgers', force: :cascade do |t|
    t.bigint 'customer_id', null: false
    t.bigint 'supplier_id', null: false
    t.bigint 'invoice_id', null: false
    t.bigint 'purchase_invoice_id', null: false
    t.bigint 'payment_id', null: false
    t.decimal 'debit', precision: 12, scale: 2, default: '0.0'
    t.decimal 'credit', precision: 12, scale: 2, default: '0.0'
    t.date 'entry_date'
    t.string 'description'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['customer_id'], name: 'index_ledgers_on_customer_id'
    t.index ['invoice_id'], name: 'index_ledgers_on_invoice_id'
    t.index ['payment_id'], name: 'index_ledgers_on_payment_id'
    t.index ['purchase_invoice_id'], name: 'index_ledgers_on_purchase_invoice_id'
    t.index ['supplier_id'], name: 'index_ledgers_on_supplier_id'
  end

  create_table 'notifications', force: :cascade do |t|
    t.bigint 'user_id', null: false
    t.string 'message'
    t.boolean 'read'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_notifications_on_user_id'
  end

  create_table 'payments', force: :cascade do |t|
    t.bigint 'invoice_id', null: false
    t.bigint 'purchase_invoice_id', null: false
    t.bigint 'customer_id', null: false
    t.bigint 'supplier_id', null: false
    t.decimal 'amount', precision: 12, scale: 2, null: false
    t.string 'payment_mode'
    t.string 'transaction_ref'
    t.date 'payment_date'
    t.text 'note'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['customer_id'], name: 'index_payments_on_customer_id'
    t.index ['invoice_id'], name: 'index_payments_on_invoice_id'
    t.index ['purchase_invoice_id'], name: 'index_payments_on_purchase_invoice_id'
    t.index ['supplier_id'], name: 'index_payments_on_supplier_id'
  end

  create_table 'products', force: :cascade do |t|
    t.string 'name'
    t.string 'description'
    t.decimal 'price'
    t.bigint 'company_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_products_on_company_id'
  end

  create_table 'purchase_invoice_products', force: :cascade do |t|
    t.bigint 'purchase_invoice_id', null: false
    t.bigint 'product_id', null: false
    t.integer 'quantity'
    t.decimal 'unit_price'
    t.decimal 'total_price'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['product_id'], name: 'index_purchase_invoice_products_on_product_id'
    t.index ['purchase_invoice_id'], name: 'index_purchase_invoice_products_on_purchase_invoice_id'
  end

  create_table 'purchase_invoices', force: :cascade do |t|
    t.bigint 'supplier_id', null: false
    t.string 'invoice_number'
    t.date 'invoice_date'
    t.decimal 'total_amount'
    t.text 'notes'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['supplier_id'], name: 'index_purchase_invoices_on_supplier_id'
  end

  create_table 'stock_movements', force: :cascade do |t|
    t.bigint 'branch_id', null: false
    t.bigint 'product_id', null: false
    t.integer 'quantity', null: false
    t.integer 'movement_type', default: 0, null: false
    t.string 'reference_type'
    t.bigint 'reference_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'stock_id', null: false
    t.index ['branch_id'], name: 'index_stock_movements_on_branch_id'
    t.index ['product_id'], name: 'index_stock_movements_on_product_id'
    t.index %w[reference_type reference_id], name: 'index_stock_movements_on_reference_type_and_reference_id'
    t.index ['stock_id'], name: 'index_stock_movements_on_stock_id'
  end

  create_table 'stock_transfer_requests', force: :cascade do |t|
    t.bigint 'source_branch_id', null: false
    t.bigint 'destination_branch_id', null: false
    t.bigint 'product_id', null: false
    t.bigint 'requested_by_id', null: false
    t.bigint 'approved_by_id'
    t.integer 'quantity', null: false
    t.integer 'status', default: 0
    t.text 'notes'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['approved_by_id'], name: 'index_stock_transfer_requests_on_approved_by_id'
    t.index ['destination_branch_id'], name: 'index_stock_transfer_requests_on_destination_branch_id'
    t.index ['product_id'], name: 'index_stock_transfer_requests_on_product_id'
    t.index ['requested_by_id'], name: 'index_stock_transfer_requests_on_requested_by_id'
    t.index ['source_branch_id'], name: 'index_stock_transfer_requests_on_source_branch_id'
  end

  create_table 'stocks', force: :cascade do |t|
    t.bigint 'company_id', null: false
    t.bigint 'product_id', null: false
    t.integer 'quantity'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_stocks_on_company_id'
    t.index ['product_id'], name: 'index_stocks_on_product_id'
  end

  create_table 'suppliers', force: :cascade do |t|
    t.string 'name'
    t.string 'gstin'
    t.string 'email'
    t.string 'phone'
    t.text 'address'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.bigint 'company_id', null: false
    t.string 'name', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.integer 'failed_attempts', default: 0, null: false
    t.string 'unlock_token'
    t.datetime 'locked_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'branch_id'
    t.integer 'role'
    t.index ['branch_id'], name: 'index_users_on_branch_id'
    t.index ['company_id'], name: 'index_users_on_company_id'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['unlock_token'], name: 'index_users_on_unlock_token', unique: true
  end

  add_foreign_key 'branch_stocks', 'branches'
  add_foreign_key 'branch_stocks', 'products'
  add_foreign_key 'branch_stocks', 'stocks'
  add_foreign_key 'branches', 'companies'
  add_foreign_key 'customers', 'companies'
  add_foreign_key 'customers', 'users'
  add_foreign_key 'invoices', 'companies'
  add_foreign_key 'invoices', 'customers'
  add_foreign_key 'invoices', 'users'
  add_foreign_key 'ledgers', 'customers'
  add_foreign_key 'ledgers', 'invoices'
  add_foreign_key 'ledgers', 'payments'
  add_foreign_key 'ledgers', 'purchase_invoices'
  add_foreign_key 'ledgers', 'suppliers'
  add_foreign_key 'notifications', 'users'
  add_foreign_key 'payments', 'customers'
  add_foreign_key 'payments', 'invoices'
  add_foreign_key 'payments', 'purchase_invoices'
  add_foreign_key 'payments', 'suppliers'
  add_foreign_key 'products', 'companies'
  add_foreign_key 'purchase_invoice_products', 'products'
  add_foreign_key 'purchase_invoice_products', 'purchase_invoices'
  add_foreign_key 'purchase_invoices', 'suppliers'
  add_foreign_key 'stock_movements', 'branches'
  add_foreign_key 'stock_movements', 'products'
  add_foreign_key 'stock_movements', 'stocks'
  add_foreign_key 'stock_transfer_requests', 'branches', column: 'destination_branch_id'
  add_foreign_key 'stock_transfer_requests', 'branches', column: 'source_branch_id'
  add_foreign_key 'stock_transfer_requests', 'products'
  add_foreign_key 'stock_transfer_requests', 'users', column: 'approved_by_id'
  add_foreign_key 'stock_transfer_requests', 'users', column: 'requested_by_id'
  add_foreign_key 'stocks', 'companies'
  add_foreign_key 'stocks', 'products'
  add_foreign_key 'users', 'branches'
  add_foreign_key 'users', 'companies'
end
