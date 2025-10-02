# frozen_string_literal: true

# :nodoc:
class Customer < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :invoices, dependent: :destroy
  has_many :payments, dependent: :nullify
  has_many :ledgers, dependent: :nullify
end
