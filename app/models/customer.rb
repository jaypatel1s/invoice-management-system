class Customer < ApplicationRecord
  belongs_to :company
  belongs_to :user
  has_many :invoices, dependent: :destroy
end
