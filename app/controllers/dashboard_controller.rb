class DashboardController < ApplicationController
  before_filter :require_user
  before_filter :set_current_tab

  def index
    @active_rooms = Room.active_rooms
  end

  def show_room
    @room = Room.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  def change_room
    @room = Room.find(params[:id])
    respond_to do |format|
      format.js
      format.html
    end
  end

  private
  def set_current_tab
    @current_tab = :dashboard
  end

end
