require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'associations' do
    it { should have_many(:borrowed_things).class_name('Thing').with_foreign_key(:borrower_id) }
    it { should have_many(:things).dependent(:destroy) }
    it { should have_many(:transactions_as_borrower).class_name('Transaction').with_foreign_key(:borrower_id) }
    it { should have_many(:transactions_as_lender).class_name('Transaction').with_foreign_key(:lender_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:last_name) }

    it { should validate_length_of(:first_name).is_at_most(50) }
    it { should validate_length_of(:last_name).is_at_most(75) }
    it { should validate_length_of(:nickname).is_at_most(100) }
  end
end
