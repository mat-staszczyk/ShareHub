class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :borrowed_things, class_name: 'Thing', foreign_key: 'borrower_id'
  has_many :things, dependent: :destroy
  has_many :transactions_as_borrower, class_name: 'Transaction', foreign_key: 'borrower_id'
  has_many :transactions_as_lender, class_name: 'Transaction', foreign_key: 'lender_id'

  validates :first_name, presence: true, length: { maximum: 50 }
  validates :last_name,  presence: true, length: { maximum: 75 }
  validates :nickname,   length: { maximum: 100 }
end
