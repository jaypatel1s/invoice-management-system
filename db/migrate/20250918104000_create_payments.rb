class CreatePayments < ActiveRecord::Migration[7.1]
  def change
    create_table :payments do |t|
      t.references :invoice, null: false, foreign_key: true
      t.references :purchase_invoice, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.decimal :amount, precision: 12, scale: 2, null: false
      t.string :payment_mode
      t.string :transaction_ref
      t.date :payment_date
      t.text :note

      t.timestamps
    end
  end
end
