# frozen_string_literal: true

# :nodoc:
class StockMovement < ApplicationRecord
  belongs_to :branch, optional: true
  belongs_to :product
  belongs_to :stock

  enum movement_type: { purchase: 0, sale: 1, transfer_in: 2, transfer_out: 3, adjustment: 4, initial: 5 }

  belongs_to :reference, polymorphic: true, optional: true

  validates :quantity, numericality: { greater_than: 0 }
end
