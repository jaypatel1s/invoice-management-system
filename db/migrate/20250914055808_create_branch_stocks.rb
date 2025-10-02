# frozen_string_literal: true

# :nodoc:
class CreateBranchStocks < ActiveRecord::Migration[7.1]
  def change
    create_table :branch_stocks do |t|
      t.references :branch, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :quantity, null: false, default: 0

      t.timestamps
    end

    add_index :branch_stocks, %i[branch_id product_id], unique: true
  end
end
