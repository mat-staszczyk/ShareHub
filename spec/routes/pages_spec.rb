require "rails_helper"

RSpec.describe 'routes to the static pages', type: :routing do
  it { expect(get: '/').to route_to('pages#home') }
end
