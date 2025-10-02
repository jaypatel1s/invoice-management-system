# frozen_string_literal: true

# :nodoc:
class AddStockRefToBranchStocks < ActiveRecord::Migration[7.1]
  def change
    add_reference :branch_stocks, :stock, null: false, foreign_key: true
  end
end
