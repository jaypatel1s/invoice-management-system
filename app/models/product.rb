# frozen_string_literal: true

# :nodoc:
class Product < ApplicationRecord
  belongs_to :company
  has_many :stocks, dependent: :destroy
  has_many :branch_stocks, through: :stocks
  has_many :stock_movements, dependent: :destroy
  validates :tax_rate, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }

  after_initialize :set_default_tax_rate, if: :new_record?

  def set_default_tax_rate
    self.tax_rate ||= 0.0
  end
end
