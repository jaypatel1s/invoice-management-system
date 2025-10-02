class BranchStock < ApplicationRecord
  belongs_to :branch
  belongs_to :product
  belongs_to :stock

  validates :quantity, numericality: { greater_than_or_equal_to: 0 }
end
