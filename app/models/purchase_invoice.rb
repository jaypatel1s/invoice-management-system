class PurchaseInvoice < ApplicationRecord
  belongs_to :supplier
  has_many :payments
  has_many :ledgers
end
