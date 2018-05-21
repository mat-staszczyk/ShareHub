require 'rails_helper'

RSpec.describe Transaction, type: :model do
  describe 'associations' do
    it { should belong_to(:lender).class_name('User') }
    it { should belong_to(:borrower).class_name('User') }
    it { should belong_to(:thing) }

    it { should have_db_index(:borrower_id) }
    it { should have_db_index(:lender_id) }
    it { should have_db_index(:thing_id) }
  end
end
