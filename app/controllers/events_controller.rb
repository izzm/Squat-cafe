class EventsController < ApplicationController
  def index
    @events = Event.on_site
  end
end
