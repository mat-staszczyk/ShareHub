require "rails_helper"

RSpec.describe 'routes to the things', type: :routing do
  it { expect(get: 'things').to route_to('things#index') }
end
