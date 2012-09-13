class CheckinsController < ApplicationController
  before_filter :require_user
  before_filter :set_current_tab

  # GET /checkins
  # GET /checkins.xml
  def index
    @checkins = Checkin.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml { render :xml => @checkins }
    end
  end

  # GET /checkins/1
  # GET /checkins/1.xml
  def show
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml { render :xml => @checkin }
    end
  end

  # GET /checkins/new
  # GET /checkins/new.xml
  def new
    @checkin = Checkin.new (params[:id])
    @checkin.action="new"
    respond_to do |format|
      format.html # new.html.erb
      format.xml { render :xml => @checkin }
    end
  end

  # GET /checkins/1/edit
  def edit
    @checkin = Checkin.find(params[:id])
  end

  # POST /checkins
  # POST /checkins.xml
  def create
    @checkin = Checkin.new(params[:checkin])

    respond_to do |format|
      #usr=User.find_by_username(@current_user.username)
      #@checkin.user_id=usr.id

      if @checkin.save
        format.html { redirect_to(dashboard_index_path, :notice => 'Checkin was successfully created.') }
        format.xml { render :xml => @checkin, :status => :created, :location => @checkin }
      else
        format.html { render :action => "new" }
        format.xml { render :xml => @checkin.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /checkins/1
  # PUT /checkins/1.xml
  def update
    @checkin = Checkin.find(params[:id])

    respond_to do |format|
      if @checkin.update_attributes(params[:checkin])
        format.html { redirect_to(@checkin, :notice => 'Checkin was successfully updated.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @checkin.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /checkins/1
  # DELETE /checkins/1.xml
  def destroy
    @checkin = Checkin.find(params[:id])
    @checkin.destroy

    respond_to do |format|
      format.html { redirect_to(checkins_url) }
      format.xml { head :ok }
    end
  end

  def checkin
    usr=User.find_by_username(@current_user.username)
    @checkin = Checkin.new(:room_id=>params[:room_id], :customer_id=>params[:customer_id], :op=>'checkin', :user_id=>usr.id)
    @checkin.check_in=Time.now.utc - (5).hours

  end

  def checkout
    @checkin = Checkin.find(params[:id])
    respond_to do |format|
      @checkin.op='checkout'
      if @checkin.update_attributes(params[:checkin])
        format.html { redirect_to(dashboard_index_path, :notice => 'Checked out successfully.') }
        format.xml { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml { render :xml => @checkin.errors, :status => :unprocessable_entity }
      end
    end
  end

  def select_customer
    @checkin = Checkin.new(:room_id=>params[:room_id])
    @customers= Customer.all

  end

  def search

    @customers = Customer.search(params[:search])
    respond_to do |format|
      format.html
      format.js
      format.xml { render :xml => @customers }
    end
  end

  def set_current_tab
    @current_tab = :dashboard
  end

end
