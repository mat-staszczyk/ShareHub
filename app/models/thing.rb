class Thing < ApplicationRecord
  belongs_to :user
  belongs_to :borrower, class_name: 'User', optional: true
end
