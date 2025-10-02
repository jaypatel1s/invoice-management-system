# frozen_string_literal: true

# :nodoc:
class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  belongs_to :user
  has_many :payments
  has_many :ledgers
end
