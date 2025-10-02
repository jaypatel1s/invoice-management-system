# frozen_string_literal: true

# :nodoc:
class Stock < ApplicationRecord
  belongs_to :company
  belongs_to :product
  has_many :branch_stocks, dependent: :destroy
  has_many :stock_movements, dependent: :destroy

  validates :product_id, presence: true, uniqueness: { scope: :company_id }
end
