class Company < ApplicationRecord
  has_many :users, dependent: :destroy

  validates :name, presence: true
  validates :address, presence: true
  validates :phone, presence: true
  validates :email, presence: true
  validates :tax_id, presence: true
end
