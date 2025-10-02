# frozen_string_literal: true

# :nodoc:
class CreatePurchaseInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_invoices do |t|
      t.references :supplier, null: false, foreign_key: true
      t.string :invoice_number
      t.date :invoice_date
      t.decimal :total_amount
      t.text :notes

      t.timestamps
    end
  end
end
