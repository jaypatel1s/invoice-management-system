class CreatePurchaseInvoiceProducts < ActiveRecord::Migration[7.1]
  def change
    create_table :purchase_invoice_products do |t|
      t.references :purchase_invoice, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity
      t.decimal :unit_price
      t.decimal :total_price

      t.timestamps
    end
  end
end
