class EventsController < ApplicationController

  def new
    @event = Event.new
  end

  def create
    @event = Event.create(event_params)
    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def show
    @event = Event.find(params[:id])
  end

  def index
    # TODO: paginate
    @events = Event.all
    respond_to do |format|
      format.html
      format.json { render json: @events }
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to calendar_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :venue, :description, :start_at, :end_at).merge(user: current_user)
  end
end