require 'rails_helper'

RSpec.describe LendingForm, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of(:thing_id) }
    it { is_expected.to validate_presence_of(:lender_id) }
    it { is_expected.to validate_presence_of(:borrower_id) }
    it { is_expected.to validate_presence_of(:borrowed_at) }
    it { is_expected.to validate_presence_of(:return_planned_at) }
  end
end
