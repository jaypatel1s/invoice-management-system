# frozen_string_literal: true

# :nodoc:
class Ledger < ApplicationRecord
  belongs_to :customer, optional: true
  belongs_to :supplier, optional: true
  belongs_to :invoice, optional: true
  belongs_to :purchase_invoice, optional: true
  belongs_to :payment, optional: true
end
