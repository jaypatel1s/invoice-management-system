# frozen_string_literal: true

# :nodoc:
class CreateInvoiceProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :invoice_products do |t|
      t.references :invoice, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, default: 1
      t.decimal :unit_price, precision: 10, scale: 2
      t.decimal :tax, precision: 10, scale: 2, default: 0
      t.decimal :total, precision: 12, scale: 2
      t.timestamps
    end
  end
end
