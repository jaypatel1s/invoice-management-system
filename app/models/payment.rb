# frozen_string_literal: true

# :nodoc:
class Payment < ApplicationRecord
  belongs_to :invoice, optional: true
  belongs_to :purchase_invoice, optional: true
  belongs_to :customer, optional: true
  belongs_to :supplier, optional: true

  has_one :ledger, dependent: :destroy
end
