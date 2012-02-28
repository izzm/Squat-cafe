class EventsController < ApplicationController
  def index
    @events = Event.on_site
  end

  def bydate
    redirect_to events_url(:anchor => params[:date])
  end
end
