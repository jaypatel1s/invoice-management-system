# frozen_string_literal: true

# :nodoc:
class AddTaxRateToProducts < ActiveRecord::Migration[6.1]
  def change
    add_column :products, :tax_rate, :decimal, precision: 5, scale: 2, default: 0.0
  end
end
