require 'rails_helper'

RSpec.describe ThingsController, type: :controller do
  describe 'GET #index' do
    subject { get :index }

    it 'returns status 200' do
      is_expected.to have_http_status(200)
    end

    it 'calls .all on Things model' do
      expect(Thing).to receive(:all)
      subject
    end
  end
end
