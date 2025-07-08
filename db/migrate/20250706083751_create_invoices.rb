class CreateInvoices < ActiveRecord::Migration[7.1]
  def change
    create_table :invoices do |t|
      t.string :invoice_number
      t.date :date
      t.date :due_date
      t.string :status
      t.text :note
      t.references :company, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
