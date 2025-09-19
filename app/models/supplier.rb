class Supplier < ApplicationRecord
  has_many :purchase_invoices
  has_many :payments
  has_many :ledgers
end
