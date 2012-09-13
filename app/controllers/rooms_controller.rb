class RoomsController < ApplicationController
  before_filter :load
  before_filter :require_user
  before_filter :set_current_tab
  before_filter :require_admin, :only => [:create, :destroy]

  def load
    @rooms = Room.all
    @room = Room.new

  end

  # GET /rooms
  # GET /rooms.xml
  def index
    @rooms = Room.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @rooms }
    end
  end

  def upd
      @room = Room.find(params[:id])
      respond_to do |format|
        format.js
      end
    end

  def show
    @room = Room.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @room }
    end
  end

  def new
    @room = Room.new
    respond_to do |format|
      format.html # new.html.erb
      format.js # index.html.erb
      format.xml { render :xml => @room }
    end
  end

  def clear
    @room = Room.new
    respond_to do |format|
      format.html # new.html.erb
      format.js # index.html.erb
    end
  end

  def edit
    @room = Room.find(params[:id])
    respond_to do |format|
      format.html # new.html.erb
      format.js # index.html.erb
    end
  end

  def create
    @room = Room.new(params[:room])
    respond_to do |format|
      if @room.save
        format.html { redirect_to(@room, :notice => 'Room was successfully created.') }
        format.js
      else
        format.html { render :action => "new" }
        format.js { render :action => 'create_error' }
      end
    end
  end

  # PUT /rooms/1
  # PUT /rooms/1.xml
  def update
    @room = Room.find(params[:id])
    respond_to do |format|
      if @room.update_attributes(params[:room])
        format.html { redirect_to(rooms_url, :notice => 'Customer was successfully updated.') }
        format.js { render :action => 'updated' }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @room.errors, :status => :unprocessable_entity }
        format.js { render :action => 'create_error' }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.xml
  def destroy

    @room = Room.find(params[:id])
    @room.destroy
    respond_to do |format|
      format.html { redirect_to(rooms_url) }
      format.xml { rooms :ok }
    end
  end

  def rooms_destroy
    @room = Room.find(params[:id])
    if @room.destroy
      flash[:notice] = "deleted room."
      redirect_to rooms_url
    else
      render :action => 'index'
    end
  end

  def set_current_tab
    @current_tab = :rooms
  end
end
