# frozen_string_literal: true

# :nodoc:
class AddStockRefToStockMovements < ActiveRecord::Migration[7.1]
  def change
    add_reference :stock_movements, :stock, null: false, foreign_key: true
  end
end
