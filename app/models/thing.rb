class Thing < ApplicationRecord
  belongs_to :user
  belongs_to :borrower, class_name: 'User', optional: true

  validates :name, presence: true, length: { maximum: 255 }

  has_one_attached :header_image
  has_many_attached :uploads
end
