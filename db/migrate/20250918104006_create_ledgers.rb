class CreateLedgers < ActiveRecord::Migration[7.1]
  def change
    create_table :ledgers do |t|
      t.references :customer, null: false, foreign_key: true
      t.references :supplier, null: false, foreign_key: true
      t.references :invoice, null: false, foreign_key: true
      t.references :purchase_invoice, null: false, foreign_key: true
      t.references :payment, null: false, foreign_key: true
      t.decimal :debit, precision: 12, scale: 2, default: 0
      t.decimal :credit, precision: 12, scale: 2, default: 0
      t.date :entry_date
      t.string :description

      t.timestamps
    end
  end
end
