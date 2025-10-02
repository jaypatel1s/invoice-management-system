# frozen_string_literal: true

# :nodoc:
class Product < ApplicationRecord
  belongs_to :company
  has_many :stocks, dependent: :destroy
  has_many :branch_stocks, through: :stocks
  has_many :stock_movements, dependent: :destroy
end
