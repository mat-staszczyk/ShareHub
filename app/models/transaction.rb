class Transaction < ApplicationRecord
  belongs_to :lender, class_name: 'User'
  belongs_to :borrower, class_name: 'User'
  belongs_to :thing
end
