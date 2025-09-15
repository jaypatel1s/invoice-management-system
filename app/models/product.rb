class Product < ApplicationRecord
  belongs_to :company
  has_many :branch_stocks
  has_many :stock_movements
end
