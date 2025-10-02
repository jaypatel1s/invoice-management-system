# frozen_string_literal: true

# :nodoc:
class CreateStockTransferRequests < ActiveRecord::Migration[7.1]
  def change
    create_table :stock_transfer_requests do |t|
      t.references :source_branch, null: false, foreign_key: { to_table: :branches }
      t.references :destination_branch, null: false, foreign_key: { to_table: :branches }
      t.references :product, null: false, foreign_key: true
      t.references :requested_by, null: false, foreign_key: { to_table: :users }
      t.references :approved_by, foreign_key: { to_table: :users }
      t.integer :quantity, null: false
      t.integer :status, default: 0
      t.text :notes

      t.timestamps
    end
  end
end
