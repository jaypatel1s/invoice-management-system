class BranchStock < ApplicationRecord
  belongs_to :branch
  belongs_to :product
  belongs_to :stock

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }

  after_create :log_initial_stock

  def adjust!(qty, movement_type: :adjustment, reference: nil)
    update!(quantity: self.quantity + qty)
    StockMovement.create!(
      branch: branch,
      stock: stock,
      product: product,
      quantity: qty.abs,
      movement_type: movement_type,
      reference: reference
    )
  end

  def log_initial_stock
    StockMovement.create!(
      branch: branch,
      stock: stock,
      product: product,
      quantity: quantity,
      movement_type: :purchase,   # or :initial_stock
      reference: self
    )
  end
end
