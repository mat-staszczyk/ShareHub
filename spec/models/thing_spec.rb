require 'rails_helper'

RSpec.describe Thing, type: :model do
  describe 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:borrower).class_name('User') }

    it { should have_db_index(:borrower_id) }
    it { should have_db_index(:user_id) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(255) }
  end
end
