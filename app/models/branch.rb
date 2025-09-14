class Branch < ApplicationRecord
  belongs_to :company
  has_many :users, dependent: :destroy
  has_many :branch_stocks, dependent: :destroy
  has_many :stock_movements, dependent: :destroy
end
