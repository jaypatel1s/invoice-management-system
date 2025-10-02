# frozen_string_literal: true

# :nodoc:
class StockTransferRequest < ApplicationRecord
  belongs_to :source_branch, class_name: 'Branch'
  belongs_to :destination_branch, class_name: 'Branch'
  belongs_to :product
  belongs_to :requested_by, class_name: 'User'
  belongs_to :approved_by, class_name: 'User', optional: true

  enum status: { pending: 0, approved: 1, rejected: 2 }

  validates :quantity, numericality: { greater_than: 0 }
end
