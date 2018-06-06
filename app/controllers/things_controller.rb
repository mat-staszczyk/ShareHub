class ThingsController < ApplicationController
  def index
    things = Thing.all

    render locals: { things: things }
  end

  def show
    thing = Thing.with_attached_uploads.find(params[:id])

    render locals: { thing: thing }
  end

  def new
    thing = current_user.things.new

    render locals: { thing: thing }
  end

  def create
    thing = current_user.things.new(thing_params)

    if thing.save
      redirect_to thing
    else
      render :new, locals: { thing: thing }
    end
  end

  private

  def thing_params
    params.require(:thing).permit(:name, :visible, :description, :header_image, uploads: [])
  end
end
