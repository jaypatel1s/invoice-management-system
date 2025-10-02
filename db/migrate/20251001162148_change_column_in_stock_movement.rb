# frozen_string_literal: true

# :nodoc:
class ChangeColumnInStockMovement < ActiveRecord::Migration[7.1]
  def change
    change_column_null :stock_movements, :branch_id, true
  end
end
