#encoding UTF-8
class EventsController < ApplicationController
  before_filter :set_event, except: [:index, :all_events, :new, :create]

  def index
    @q = Event.where("event_date >= ?", Date.today).ransack(params[:q])
    @events = @q.result(distinct: true).order("event_date asc")
  end

  def all_events
    @events = Event.all.order("event_date asc")
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_attributes)
    if @event.save
      redirect_to events_path, notice: "Uspješno dodana svirka"
    else
      render "new"
    end
  end

  def edit
  end

  def update
    if @event.update_attributes(event_attributes)
      redirect_to events_path, notice: "Uspješno ažurirana svirka"
    else
      render :edit
    end
  end

  def show
  end

  def destroy
  end

  private
  def set_event
    @event = Event.find(params[:id])
  end

  def event_attributes
    params.require(:event).permit(:id, :name, :event_date, :description, :price, :valute, :public)
  end
end
