class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:confirmable, :lockable, :timeoutable, :trackable, timeout_in: 30.minutes
  belongs_to :company
  has_many :customers, dependent: :destroy
  has_many :invoices, dependent: :destroy
end
