class Invoice < ApplicationRecord
  belongs_to :company
  belongs_to :customer
  belongs_to :user
end
