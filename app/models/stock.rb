class Stock < ApplicationRecord
  belongs_to :company
  belongs_to :product
  has_many :branch_stocks
  has_many :stock_movements

  validates :product_id, presence: true, uniqueness: { scope: :company_id }
end
