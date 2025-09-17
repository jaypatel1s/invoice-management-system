class StockMovement < ApplicationRecord
  belongs_to :branch
  belongs_to :product
  belongs_to :stock

  enum movement_type: { purchase: 0, sale: 1, transfer_in: 2, transfer_out: 3, adjustment: 4 }

  # optional reference (invoice, transfer, branch_stock, etc.)
  belongs_to :reference, polymorphic: true, optional: true

  validates :quantity, numericality: { greater_than: 0 }
end
