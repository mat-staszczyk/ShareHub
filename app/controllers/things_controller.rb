class ThingsController < ApplicationController
  def index
    things = Thing.all

    render locals: { things: things }
  end
end
