# frozen_string_literal: true

# :nodoc:
class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  belongs_to :user
  has_many :payments, dependent: :destroy
  has_many :ledgers, dependent: :destroy
  has_many :invoice_products, dependent: :destroy
  has_many :products, through: :invoice_products
  accepts_nested_attributes_for :invoice_products, allow_destroy: true, reject_if: :all_blank
  enum status: { draft: 0, sent: 1, paid: 2, overdue: 3, cancelled: 4 }, _default: :draft
  validates :invoice_number, presence: true, uniqueness: { scope: :company_id }
  before_create :set_invoice_number

  def set_invoice_number
    count = company.invoices.count + 1
    self.invoice_number = "TX#{count}"
  end

  def subtotal
    invoice_products.sum('quantity * unit_price')
  end

  def total_tax
    invoice_products.sum(:tax)
  end

  def grand_total
    subtotal + total_tax
  end
end
