class Thing < ApplicationRecord
  belongs_to :user
  belongs_to :borrower, class_name: 'User', optional: true

  validates :name, presence: true, length: { maximum: 255 }
end
