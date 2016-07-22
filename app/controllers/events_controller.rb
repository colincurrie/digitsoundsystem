class EventsController < ApplicationController

  def new
    redirect_to(calendar_path) unless current_user.try(:admin?)
    @event = Event.new
  end

  def create
    redirect_to(calendar_path) unless current_user.try(:admin?)
    @event = Event.create(event_params)
    if @event.save
      redirect_to events_path
    else
      render 'new'
    end
  end

  def edit
    redirect_to(calendar_path) unless current_user.try(:admin?)
    @event = Event.find(params[:id])
  end

  def update
    redirect_to(calendar_path) unless current_user.try(:admin?)
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to calendar_path
    else
      render 'edit'
    end
  end

  def show
    @event = Event.find(params[:id])
    @comments = @event.comments.page(page).per_page(per_page)
  end

  def index
    @events = Event.all
    respond_to do |format|
      format.html
      format.json { render json: @events }
    end
  end

  def destroy
    if admin?
      @event = Event.find(params[:id])
      @event.destroy
    end
    redirect_to calendar_path
  end

  private

  def event_params
    params.require(:event).permit(:title, :venue, :description, :start_at, :end_at).merge(user: current_user)
  end
end